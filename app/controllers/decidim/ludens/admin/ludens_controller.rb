# frozen_string_literal: true

module Decidim
  module Ludens
    module Admin
      class LudensController < Ludens::Admin::ApplicationController
        helper Decidim::Ludens::LudensHelper
        def toggle
          # TODO: Add permission check
          current_user.update!(enable_ludens: !current_user.ludens_enabled?)

          redirect_to action: "show"
        end
      end
    end
  end
end
