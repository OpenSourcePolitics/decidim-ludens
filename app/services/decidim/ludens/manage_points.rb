# frozen_string_literal: true

module Decidim
  module Ludens
    class ManagePoints
      def initialize(action, user, resource)
        @user = user
        @action = action.to_s
        @resource = resource
      end

      def run
        return unless Decidim::Ludens::ParticipativeActionCompleted.table_exists?
        return unless @user.admin?
        return if participative_action.blank?
        return if Decidim::Ludens::ParticipativeActionCompleted.exists?(user: @user, decidim_participative_action: participative_action.global_id)

        level_before = @user.participative_actions_level
        create_participative_action_completed
        send_info_in_cache(has_leveled_up?(@user, level_before))
        true
      end

      private

      def create_participative_action_completed
        ParticipativeActionCompleted.create!(user: @user, decidim_participative_action: participative_action.global_id)
      end

      def send_info_in_cache(level_up)
        flash_message = I18n.t("decidim.admin.assistant.success", recommendation: participative_action.translated_recommendation)
        Rails.cache.write("flash_message_#{@user.id}", flash_message)

        Rails.cache.write("level_up_#{@user.id}", "reached") if level_up
      end

      def participative_action
        @participative_action ||= Decidim::Ludens::ParticipativeAction.find_by(action: @action, resource: @resource.class.to_s)
                                                                      .first
      end

      def has_leveled_up?(user, level_before)
        user.participative_actions_completed.reload
        user.participative_actions_level > level_before
      end
    end
  end
end
