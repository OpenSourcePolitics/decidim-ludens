# frozen_string_literal: true

module Decidim
  module Ludens
    class SetupService
      def initialize(organization)
        @organization = organization
      end

      def self.actions
        if File.exist?(Rails.root.join("config/participative_actions.yaml"))
          YAML.safe_load(File.read(Rails.root.join("config/participative_actions.yaml")))
        else
          YAML.safe_load(File.read("#{`bundle info decidim-ludens --path`.delete!("\n")}/config/participative_actions.yaml"))
        end
      end

      def self.initialize_assistant
        raise missing_tables_message unless tables_exists?

        Decidim::Organization.all.find_each do |organization|
          new(organization).create_assistant.create_actions
        end
      end

      def create_assistant
        return self unless @organization.assistant.nil?

        display("assistant") do
          @organization.update!(assistant: {
                                  score: 0,
                                  flash: "",
                                  last: -1,
                                  level_up: "unreached"
                                })
        end

        self
      end

      def create_actions
        Decidim::Ludens::ParticipativeAction.delete_all
        Decidim::Ludens::SetupService.actions["actions"].each do |category, resources|
          resources.each do |resource, actions|
            actions.each do |action, infos|
              create_action(
                infos["points"],
                resource,
                action,
                category,
                infos["recommendation"],
                infos["documentation"]
              )
            end
          end
        end
      end

      def self.tables_exists?
        Decidim::Organization.table_exists? && Decidim::Ludens::ParticipativeAction.table_exists?
      end

      def self.missing_tables_message
        "Unknown table Organization or Participative action, please run migration first"
      end

      def self.retrieve_actions
        raise missing_tables_message unless tables_exists?

        Decidim::Organization.all.find_each do |organization|
          Decidim::ActionLog.where(organization: organization).find_each do |log|
            puts "Action added : #{log.action} - #{log.resource.class}" if Decidim::Ludens::ManagePoints.run(log.action, log.user, log.resource)
          end
        end
      end

      private

      # rubocop:disable Metrics/ParameterLists
      def create_action(points, resource, action, category, recommendation, documentation)
        display(recommendation) do
          Decidim::Ludens::ParticipativeAction.find_or_initialize_by(
            points: points,
            resource: resource,
            action: action,
            category: category,
            organization: @organization,
            recommendation: recommendation,
            documentation: documentation
          )
        end
      end
      # rubocop:enable Metrics/ParameterLists

      def display(information)
        Decidim::ApplicationRecord.transaction do
          result = block_given? ? yield : nil
          if information == "assistant"
            puts "Initializing the assistant"
          else
            if result&.new_record?
              puts "Adding the action '#{information}' "
            else
              puts "Action '#{information}' already installed"
            end
            result.save! if result&.new_record?
          end
          return result
        end
      end
    end
  end
end
