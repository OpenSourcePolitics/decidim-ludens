# frozen_string_literal: true

module UserExtends
  extend ActiveSupport::Concern

  included do
    has_many :participative_actions_completed, class_name: "Decidim::Ludens::ParticipativeActionCompleted", foreign_key: "decidim_user_id", dependent: :destroy

    def participative_actions_score
      return 0 if participative_actions_completed.blank?

      participative_actions_completed.sum(&:points)
    end

    def participative_actions_level
      return 1 if Decidim::Ludens::ParticipativeAction.actions.blank?

      levels = Decidim::Ludens::ParticipativeAction.level_points
      levels.each_with_index do |level, index|
        return index + 1 if participative_actions_score < level
      end
      levels.size
    end

    def ludens_enabled?
      return enable_ludens unless enable_ludens.nil?

      Decidim::Ludens.enable_ludens
    end
  end
end

Decidim::User.class_eval do
  include(UserExtends)
end
