# frozen_string_literal: true

module AdminControllerExtends
  extend ActiveSupport::Concern

  included do
    after_action :flash_points

    def flash_points
      return unless Rails.cache.exist?("flash_message_#{current_user.id}")

      flash[:info] = Rails.cache.read("flash_message_#{current_user.id}")
      Rails.cache.delete("flash_message_#{current_user.id}")
    end
  end
end
