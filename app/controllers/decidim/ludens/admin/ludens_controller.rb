# frozen_string_literal: true

module Decidim
  module Ludens
    module Admin
      class LudensController < Ludens::Admin::ApplicationController
        helper_method :list_of_participative_actions

        def show; end

        # Returns a list of participative actions
        #
        # {
        #   action_name: {
        #     completed: [Array of completed actions],
        #     uncompleted: [Array of uncompleted actions]
        #   },
        #   another_action_name: {
        #     completed: [Array of completed actions],
        #     uncompleted: [Array of uncompleted actions]
        #   }
        # }
        #
        def list_of_participative_actions
          participative_actions.group_by(&:category).each_with_object({}) do |actions_arr, hash|
            hash[actions_arr[0].downcase.to_sym] = {
              completed: actions_arr[1].select(&:completed?),
              uncompleted: actions_arr[1].reject(&:completed?)
            }
          end
        end

        private

        def participative_actions
          # TODO: Add a scope for organization
          @participative_actions ||= ParticipativeAction.all
        end
      end
    end
  end
end
