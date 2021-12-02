# frozen_string_literal: true

require "decidim/participative_assistant/test/factories"
FactoryBot.define do
  sequence(:points) { |n| n }

  factory :participative_action, class: "Decidim::ParticipativeAssistant::ParticipativeAction" do
    completed { false }
    points { generate(:points) }
    resource { "Decidim::Assembly" }
    action { "publish" }
    category { "Edition" }
    recommendation { "Publish an assembly" }
  end
end

