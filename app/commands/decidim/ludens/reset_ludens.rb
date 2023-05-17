# frozen_string_literal: true

module Decidim
  module Ludens
    # A command with all the business logic to destroy all participative actions completed by a user.
    class ResetLudens < Decidim::Command
      # Public: Initializes the command.
      #
      # user - The user to reset
      def initialize(user)
        @user = user
      end

      # Executes the command. Broadcasts these events:
      #
      # - :ok when everything is valid.
      # - :invalid if the data wasn't valid and we couldn't proceed.
      #
      # Returns nothing.
      def call
        return broadcast(:invalid) if @user.nil? || !@user.admin?

        destroy_actions
        broadcast(:ok)
      end

      private

      attr_reader :category

      def destroy_actions
        Decidim::Ludens::ParticipativeActionCompleted.where(user: @user).destroy_all
      end
    end
  end
end
