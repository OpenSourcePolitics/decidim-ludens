# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/ludens/version"

Gem::Specification.new do |s|
  s.version = Decidim::Ludens.version
  s.authors = [""]
  s.email = [""]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/OpenSourcePolitics/decidim-ludens"
  s.required_ruby_version = ">= 2.7"

  s.name = "decidim-ludens"
  s.summary = "A decidim participative assistant gamified module"
  s.description = "Participative Assistant for administrators."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "package.json", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", "~> #{Decidim::Ludens.compatible_decidim_version}"
end
