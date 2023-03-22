# frozen_string_literal: true

module Decidim
  module Ludens
    module LudensHelper
      def last_completed
        @last_completed ||= Decidim::Ludens::ParticipativeActionCompleted.last
      end

      def participative_actions_score(user)
        user.participative_actions_score
      end

      def participative_actions_level(user)
        user.participative_actions_level
      end

      def participative_actions_level_points(user = nil)
        level_points = Decidim::Ludens::ParticipativeAction.level_points

        user ? level_points[user.participative_actions_level - 1] : level_points
      end

      def participative_actions_recommendations(current_user)
        Decidim::Ludens::ParticipativeAction.recommendations(current_user.participative_actions_completed)
      end

      def list_of_participative_actions(user)
        Decidim::Ludens::ParticipativeAction.list_of_participative_actions(user)
      end
    end
  end
end
