# frozen_string_literal: true

module UserExtends
  extend ActiveSupport::Concern

  included do
    has_many :participative_actions_completed, class_name: "Decidim::Ludens::ParticipativeActionCompleted", foreign_key: "decidim_user_id", dependent: :destroy

    def score
      return 0 if participative_actions_completed.blank?

      participative_actions_completed.sum(&:points)
    end
  end
end

Decidim::User.class_eval do
  include(UserExtends)
end
