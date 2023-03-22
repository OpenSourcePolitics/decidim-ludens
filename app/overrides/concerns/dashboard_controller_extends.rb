# frozen_string_literal: true

module DashboardControllerExtends
  extend ActiveSupport::Concern

  included do
    helper Decidim::Ludens::LudensHelper
  end
end
