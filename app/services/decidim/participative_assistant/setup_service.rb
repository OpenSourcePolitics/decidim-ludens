module Decidim
  module ParticipativeAssistant
    class SetupService
      ACTIONS = YAML.load(File.read(Rails.root.join('config', 'participative_actions.yaml')))

      def initialize(organization)
        @organization = organization
      end

      def self.initialize_assistant
        raise missing_tables_message unless tables_exists?

        Decidim::Organization.all.find_each do |organization|
          new(organization).create_assistant.create_actions
        end
      end

      def create_assistant
        return self if @organization.assistant != nil

        @organization.update!(assistant: {
          score: 0,
          flash: "",
          last: -1
        })

        self
      end

      def create_actions
        Decidim::ParticipativeAssistant::SetupService::ACTIONS.each do |category,resources|
          resources.each do |resource,actions|
            actions.each do |action,infos|
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

      private

      def create_action(points, resource, action, category, recommendation, documentation)
        Decidim::ParticipativeAssistant::ParticipativeAction.find_or_create_by!(
          points: points,
          resource: resource,
          action: action,
          category: category,
          organization: @organization,
          recommendation: recommendation,
          documentation: documentation
        )
      end

      def self.tables_exists?
        Decidim::Organization.table_exists? && Decidim::ParticipativeAssistant::ParticipativeAction.table_exists?
      end

      def self.missing_tables_message
        "Unknown table Organization or Participative action, please run migration first"
      end
    end
  end
end
