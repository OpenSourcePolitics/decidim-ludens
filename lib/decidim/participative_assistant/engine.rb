# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module ParticipativeAssistant
    # This is the engine that runs on the public interface of participative_assistant.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::ParticipativeAssistant

      config.to_prepare do
        Decidim::Organization.include Decidim::ParticipativeAssistant::OrganizationModelExtend
        require "extends/action_logger_service_extend"  #TODO : refactor
      end

      routes do
        # Add engine routes here
        # resources :participative_assistant
        # root to: "participative_assistant#index"
      end

      # def load_seed
      #   super
      # end

      initializer "ParticipativeAssistant.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end
    end
  end
end
