# frozen_string_literal: true

module Decidim
  module Ludens
    module Admin
      class LudensController < Decidim::Admin::ApplicationController
        helper Decidim::Ludens::LudensHelper

        def toggle
          enforce_permission_to :update, :admin_user, user: current_user
          current_user.update!(enable_ludens: !current_user.ludens_enabled?)

          redirect_to action: "show"
        end
      end
    end
  end
end
