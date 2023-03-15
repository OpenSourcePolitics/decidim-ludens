# frozen_string_literal: true

module Decidim
  module Ludens
    class ParticipativeActions
      include Singleton
      
      attr_accessor :actions

      def initialize
        @actions = []
        file = get_actions_from_file()
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

      def level_points
        paliers = []

        (1..5).each do |i|
          if i == 1
            paliers.append(actions.where(points: i, organization: self).size)
          else
            paliers.append(ctions.where(points: i, organization: self).size * i + paliers[i - 2])
          end
        end

        paliers
      end

      def recommandations
        #TODO : return a list of recommandations
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
      end

      private

      def get_actions_from_file
        if File.exist?(Rails.root.join("config/participative_actions.yaml"))
          YAML.safe_load(File.read(Rails.root.join("config/participative_actions.yaml")))
        else
          YAML.safe_load(File.read("#{`bundle info decidim-ludens --path`.strip}/config/participative_actions.yaml"))
        end
      end
    end
  end
end
