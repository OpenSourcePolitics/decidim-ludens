# frozen_string_literal: true

module Decidim
  module Ludens
    class ParticipativeAction
      attr_accessor :points, :resource, :action, :category, :recommendation, :documentation

      # rubocop:disable Metrics/ParameterLists
      def initialize(points:, resource:, action:, category:, recommendation:, documentation:)
        @points = points
        @resource = resource
        @action = action
        @category = category
        @recommendation = recommendation
        @documentation = documentation
      end
      # rubocop:enable Metrics/ParameterLists

      def self.actions_file
        @actions_file ||= if File.exist?(Rails.root.join("config/participative_actions.yaml"))
                            YAML.safe_load(File.read(Rails.root.join("config/participative_actions.yaml")))
                          else
                            YAML.safe_load(File.read("#{`bundle info decidim-ludens --path`.strip}/config/participative_actions.yaml"))
                          end
      end

      def self.actions
        @actions ||= actions_file.fetch("actions", []).map do |category, resources|
          resources.map do |resource, all_actions|
            all_actions.map do |action, infos|
              ParticipativeAction.new(
                points: infos["points"],
                resource: resource,
                action: action,
                category: category,
                recommendation: infos["recommendation"],
                documentation: infos["documentation"]
              )
            end
          end
        end.flatten
      end

      def self.find(global_id)
        actions.find { |a| a.global_id == global_id }
      end

      def self.find_by(**args)
        actions.select { |action| args.all? { |k, v| action.send(k) == v } }
      end

      def self.maximum_level
        actions.map(&:points).max
      end

      # Calculate level points
      # returns an array of points for each level
      # [12, 14, 34, 56, 12] -> 12 points level 1, 14 points level 2, 34 points level 3, 56 points level 4, 12 points level 5
      def self.level_points
        (1..maximum_level).to_a.map do |i|
          points_for_level(i)
        end
      end

      def self.points_for_level(level)
        return 0 if level.zero?

        (actions.select { |a| a.points == level }.size * level) + points_for_level(level - 1)
      end

      def self.list_of_participative_actions(user)
        actions.sort_by(&:points).group_by(&:category).each_with_object({}) do |actions_arr, hash|
          hash[actions_arr[0].downcase.to_sym] = {
            completed: actions_arr[1].select { |a| a.completed?(user) },
            uncompleted: actions_arr[1].reject { |a| a.completed?(user) }
          }
        end
      end

      def translated_recommendation
        I18n.t("decidim.ludens.actions.#{recommendation}")
      end

      def global_id
        "#{@action}.#{@resource}"
      end
    end
  end
end
