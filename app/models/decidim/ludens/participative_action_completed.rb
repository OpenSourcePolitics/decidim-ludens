# frozen_string_literal: true

module Decidim
  module Ludens
    class ParticipativeActionCompleted < ApplicationRecord
      self.table_name = "participative_actions_completed"

      belongs_to :user, foreign_key: "decidim_user_id", class_name: "Decidim::User"

      validates :user, uniqueness: { scope: :decidim_participative_action }
      validates :decidim_participative_action, presence: true

      delegate :points, :recommandation, to: :participative_action

      def participative_action
        @participative_action ||= Decidim::Ludens::ParticipativeAction.find(decidim_participative_action)
      end
    end
  end
end
