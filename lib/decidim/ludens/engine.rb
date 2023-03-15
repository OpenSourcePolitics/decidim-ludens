# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module Ludens
    # This is the engine that runs on the public interface of ludens.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Ludens

      config.to_prepare do
        Decidim::User.class_eval do
          include(UserExtends)
        end
        require "extends/action_logger_service_extend" # TODO : refactor
      end

      routes do
        # Add engine routes here
        # resources :ludens
        # root to: "ludens#index"
      end

      initializer "Ludens.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end
    end
  end
end
