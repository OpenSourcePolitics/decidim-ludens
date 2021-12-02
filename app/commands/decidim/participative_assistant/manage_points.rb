# frozen_string_literal: true

module Decidim
  module ParticipativeAssistant
    class ManagePoints < Rectify::Command
      def initialize(action, user, resource)
        @user = user
        @action = action
        @resource = resource
      end

      def call
        return unless participative_action.present?
        transaction do
          increase_score_by!(participative_action.points)
          participative_action.update!(completed: true)
        end
        end

      def increase_score_by!(points)
        old_data = current_organization.assistant.dup
        flash_message = "Congratulations ! You just completed the action '"+participative_action.recommendation+"' !"
        new_data = old_data.merge({
                                    score: @user.organization.increase_score(points),
                                    flash: flash_message,
                                    last: participative_action.id
                                  })
        current_organization.update!(assistant: new_data)
      end

      def participative_action
        ParticipativeAction.find_by(action: @action, resource: @resource.class.to_s, completed: false)
      end

      def current_organization
        @current_organization ||= @user.organization
      end
    end
  end
end
