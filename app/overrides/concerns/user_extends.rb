# frozen_string_literal: true

module UserExtends
  extend ActiveSupport::Concern

  included do
    has_many :participative_actions_completed, class_name: "Decidim::Ludens::ParticipativeActionCompleted", foreign_key: "decidim_user_id", dependent: :destroy

    def score
      return 0 if participative_actions_completed.blank?

      participative_actions_completed.sum(&:points)
    end

    def level
      return 1 if Decidim::Ludens::ParticipativeActions.instance.actions.blank?

      levels = Decidim::Ludens::ParticipativeActions.instance.level_points
      levels.each_with_index do |level, index|
        return index + 1 if score < level
      end
      levels.size
    end

    def ludens_enabled?
      return enable_ludens unless enable_ludens.nil?

      Decidim::Ludens.enable_ludens
    end

    def toggle_ludens
      update!(enable_ludens: !ludens_enabled?)
    end

    def recommendations
      actions = Decidim::Ludens::ParticipativeActions.instance.actions.reject { |a| a.completed?(self) }.sort_by(&:points).group_by(&:points)
      actions = actions.each { |key, value| actions[key] = value.shuffle }
      actions.values.flatten[0, 3]
    end
  end
end

Decidim::User.class_eval do
  include(UserExtends)
end
