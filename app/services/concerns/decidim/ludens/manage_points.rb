# frozen_string_literal: true

module Decidim
  module Ludens
    class ManagePoints
      def initialize(action, user, resource)
        @user = user
        @action = action.to_s
        @resource = resource
      end

      def self.run(action, user, resource)
        new(action, user, resource).call
      end

      def call
        return if participative_action.blank?

        ActiveRecord::Base.transaction do
          increase_score_by!(participative_action.points)
          participative_action.update!(completed: true)
        end
      end

      private

      def increase_score_by!(points)
        old_data = current_organization.assistant.dup
        flash_message = "#{I18n.t("decidim.admin.assistant.success")} #{participative_action.translated_recommendation} !"
        new_data = if has_reached_level?(points)
                     old_data.merge({
                                      score: current_organization.increase_score(points),
                                      flash: flash_message,
                                      last: participative_action.id,
                                      level_up: "reached"
                                    })
                   else
                     old_data.merge({
                                      score: current_organization.increase_score(points),
                                      flash: flash_message,
                                      last: participative_action.id
                                    })
                   end
        current_organization.update!(assistant: new_data)
      end

      def has_reached_level?(points)
        result = false
        current_organization.step_scores.each do |step|
          result = true if (current_organization.increase_score(points) >= step) && (current_organization.assistant["score"] < step)
        end
        result
      end

      def participative_action
        ParticipativeAction.find_by(action: @action, resource: @resource.class.to_s, completed: [false, nil], organization: current_organization)
      end

      def current_organization
        @current_organization ||= @user.organization
      end
    end
  end
end
