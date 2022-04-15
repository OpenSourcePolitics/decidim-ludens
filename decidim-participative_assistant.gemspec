# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/participative_assistant/version"

Gem::Specification.new do |s|
  s.version = Decidim::ParticipativeAssistant.version
  s.authors = [""]
  s.email = [""]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/decidim/decidim-module-participative_assistant"
  s.required_ruby_version = ">= 2.7"

  s.name = "decidim-participative_assistant"
  s.summary = "A decidim participative_assistant module"
  s.description = "Participative participative_assistant for administrators."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "package.json", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", Decidim::ParticipativeAssistant.version
end
