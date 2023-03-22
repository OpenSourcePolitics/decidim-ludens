# frozen_string_literal: true

module Decidim
  module Ludens
    class ParticipativeActions
      include Singleton

      attr_accessor :actions

      def initialize
        @actions = []
        file = actions_from_file
        file["actions"].each do |category, resources|
          resources.each do |resource, all_actions|
            all_actions.each do |action, infos|
              @actions.append(ParticipativeAction.new(
                                points: infos["points"],
                                resource: resource,
                                action: action,
                                category: category,
                                recommendation: infos["recommendation"],
                                documentation: infos["documentation"]
                              ))
            end
          end
        end
      end

      def find(action, resource)
        actions.find { |a| a.build_id == "#{action}.#{resource}" }
      end

      def level_points
        paliers = []

        (1..5).each do |i|
          if i == 1
            paliers.append(actions.select { |a| a.points == i }.size)
          else
            paliers.append(actions.select { |a| a.points == i }.size * i + paliers[i - 2])
          end
        end

        paliers
      end

      def list_of_participative_actions(user)
        actions.sort_by(&:points).group_by(&:category).each_with_object({}) do |actions_arr, hash|
          hash[actions_arr[0].downcase.to_sym] = {
            completed: actions_arr[1].select { |a| a.completed?(user) },
            uncompleted: actions_arr[1].reject { |a| a.completed?(user) }
          }
        end
      end

      class ParticipativeAction
        attr_accessor :points, :resource, :action, :category, :recommendation, :documentation

        def initialize(points:, resource:, action:, category:, recommendation:, documentation:)
          @points = points
          @resource = resource
          @action = action
          @category = category
          @recommendation = recommendation
          @documentation = documentation
        end

        def translated_recommendation
          I18n.t("decidim.ludens.actions.#{recommendation}")
        end

        def build_id
          "#{@action}.#{@resource}"
        end

        def completed?(user)
          ParticipativeActionCompleted.exists?(decidim_user_id: user.id, decidim_participative_action: build_id)
        end
      end

      private

      def actions_from_file
        if File.exist?(Rails.root.join("config/participative_actions.yaml"))
          YAML.safe_load(File.read(Rails.root.join("config/participative_actions.yaml")))
        else
          YAML.safe_load(File.read("#{`bundle info decidim-ludens --path`.strip}/config/participative_actions.yaml"))
        end
      end
    end
  end
end
