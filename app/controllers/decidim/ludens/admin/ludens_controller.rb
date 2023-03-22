# frozen_string_literal: true

module Decidim
  module Ludens
    module Admin
      class LudensController < Ludens::Admin::ApplicationController
        def toggle
          # TODO: Add permission check
          current_user.toggle_ludens

          redirect_to action: "show"
        end
      end
    end
  end
end
