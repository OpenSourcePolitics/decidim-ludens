# frozen_string_literal: true

require "decidim/core/test/factories"

FactoryBot.define do
  factory :participative_action_completed, class: "Decidim::Ludens::ParticipativeActionCompleted" do
    decidim_participative_action { "publish.Decidim::Assembly" }
    user { create(:user) }
  end
end
