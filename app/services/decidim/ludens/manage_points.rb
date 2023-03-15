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
        return if participative_action.blank?
        return if participative_action.completed?(@user)

        create_participative_action_completed
        send_flash_message_in_cache
        #TODO : handle level up
      end

      private

      def create_participative_action_completed
        participative_action_completed = ParticipativeActionCompleted.new(
          decidim_user_id: @user.id,
          decidim_participative_action: participative_action.build_id
        )
        participative_action_completed.save if participative_action_completed.valid?
      end

      def send_flash_message_in_cache
        flash_message = "#{I18n.t("decidim.admin.assistant.success")} '#{participative_action.translated_recommendation}' !"
        Rails.cache.write("flash_message_#{@user.id}", flash_message)
      end

      def participative_action
        ParticipativeActions.instance.find(@action, @resource.class.to_s)
      end
    end
  end
end
