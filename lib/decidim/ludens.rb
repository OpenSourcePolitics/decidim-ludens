# frozen_string_literal: true

require "decidim/ludens/admin"
require "decidim/ludens/engine"
require "decidim/ludens/admin_engine"

module Decidim
  # This namespace holds the logic of the `Ludens` component. This component
  # allows users to create ludens in a participatory space.
  module Ludens
    include ActiveSupport::Configurable

    config_accessor :enable_ludens do
      true
    end

    def self.actions_file
      @actions_file ||= if File.exist?(Rails.root.join("config/participative_actions.yaml"))
                          YAML.safe_load(File.read(Rails.root.join("config/participative_actions.yaml")))
                        else
                          yaml_from_file
                        end
    end

    def self.yaml_from_file
      return unless decidim_ludens_path

      YAML.safe_load(File.read(decidim_ludens_path.join("config/participative_actions.yaml")))
    end

    def self.decidim_ludens_path
      @decidim_ludens_path ||= Pathname.new(decidim_ludens_gemspec.full_gem_path) if Gem.loaded_specs.has_key?(gem_name)
    end

    def self.decidim_ludens_gemspec
      @decidim_ludens_gemspec ||= Gem.loaded_specs[gem_name]
    end

    def self.gem_name
      "decidim-ludens"
    end
  end
end
