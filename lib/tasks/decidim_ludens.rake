# frozen_string_literal: true

namespace :decidim_ludens do
  desc "Initialize participative assistant actions"
  task initialize: :environment do
    system("npm install confetti-js --save")
    Decidim::Ludens::SetupService.retrieve_actions
  end

  desc "Copy the participative actions file"
  task get_file: :environment do
    system("cp $(bundle info decidim-ludens --path)/config/participative_actions.yaml config")
  end

  desc "Retrieve old actions"
  task retrieve: :environment do
    Decidim::Ludens::SetupService.retrieve_actions
  end

  desc "Remove unregistered actions"
  task remove_unregistered_actions: :environment do
    Decidim::Ludens::SetupService.remove_unregistered_actions
  end
end
