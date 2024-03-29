# frozen_string_literal: true

module Decidim
  module Ludens
    # This is the engine that runs on the public interface of `Ludens`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Ludens::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        # resources :ludens do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "ludens#index"
        get "ludens/toggle" => "ludens#toggle", :as => :toggle_ludens
        root to: "ludens#show"
      end

      initializer "decidim_ludens.admin_mount_routes" do
        Decidim::Core::Engine.routes do
          mount Decidim::Ludens::AdminEngine, at: "/admin/ludens", as: "decidim_admin_ludens"
        end
      end

      initializer "decidim_ludens.admin_menu_add_item" do
        Decidim.menu :admin_menu do |menu|
          menu.add_item :ludens,
                        t("decidim.admin.assistant.title"),
                        "/admin/ludens",
                        icon_name: "badge",
                        position: 11
        end
      end
    end
  end
end
