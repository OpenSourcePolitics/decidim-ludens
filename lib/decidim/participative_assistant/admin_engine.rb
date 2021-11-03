# frozen_string_literal: true

module Decidim
  module ParticipativeAssistant
    # This is the engine that runs on the public interface of `ParticipativeAssistant`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::ParticipativeAssistant::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        # resources :participative_assistant do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "participative_assistant#index"
      end

      def load_seed
        nil
      end
    end
  end
end
