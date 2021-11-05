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
        root to: "participative_assistant#show"
      end

      initializer "decidim_participative_assistant.admin_mount_routes" do
        Decidim::Core::Engine.routes do
          mount Decidim::ParticipativeAssistant::AdminEngine, at: "/admin/participative_assistant", as: "decidim_admin_participative_assistant"
        end
      end

      initializer "decidim_participative_assistant.admin_menu_add_item" do
        Decidim.menu :admin_menu do |menu|
          menu.add_item :participative_assistant,
                        t("decidim.admin.assistant.title"),
                        "/admin/participative_assistant", #TODO remplacer par le nom de la route
                        icon_name: "dashboard",
                        position: 11

        end
      end

      def load_seed
        nil
      end
    end
  end
end
