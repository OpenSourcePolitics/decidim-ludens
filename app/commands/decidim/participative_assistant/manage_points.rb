# frozen_string_literal: true

module Decidim
  module ParticipativeAssistant
    class ManagePoints < Rectify::Command
      def initialize(action, user, resource)
        @user = user
        @action = action
        @resource = resource
      end

      # Executes the command. Broadcasts these events:
      #
      # - :ok when everything is valid.
      # - :invalid if the form wasn't valid and we couldn't proceed.
      #
      # Returns nothing.
      def call
        return unless participative_action.present?

        increase_score_by participative_action.points
        participative_action.completed = 1
        participative_action.save
        data = {
          event: 'decidim.events.comments.comment_created',
          event_class: Decidim::Comments::CommentCreatedEvent,
          resource: @resource,
          affected_users: [@user]
        }
        Decidim::EventsManager.publish(data)
      end

      def increase_score_by(points)
        Decidim::Organization.first.update_column('assistant', { 'score' => @user.organization.increase_score(points) })
      end

      def participative_action
        ParticipativeAction.where(action: @action, resource: @resource.class.to_s, completed: false).limit(1)[0]
      end
    end
  end
end
