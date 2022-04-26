# frozen_string_literal: true

namespace :decidim_ludens do
  desc "Initialize participative assistant actions"
  task initialize: :environment do
    system("cp $(bundle info decidim-ludens --path)/config/participative_actions.yaml config")
    system("npm install confetti-js --save")
    Decidim::Ludens::SetupService.initialize_assistant
  end
end
