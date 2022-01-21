# frozen_string_literal: true

namespace :decidim_participative_assistant do
  desc "Initialize participative assistant actions"
  task initialize: :environment do
    system("cp $(bundle info decidim-participative_assistant --path)/config/participative_actions.yaml config")
    Decidim::ParticipativeAssistant::SetupService.initialize_assistant
  end
end
