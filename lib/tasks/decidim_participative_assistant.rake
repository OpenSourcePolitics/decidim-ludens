# frozen_string_literal: true

namespace :decidim_participative_assistant do
  desc "Initialize participative assistant actions"
  task initialize: :environment do
    Decidim::ParticipativeAssistant::SetupService.initialize_assistant
  end
end
