# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Ludens
    describe SetupService do
      subject { described_class.new }

      let(:organization) { create(:organization) }
      let(:subject_class) { described_class }
      let(:user) { create(:user, :admin, organization: organization) }

      describe "#retrieve_actions" do
        before do
          Decidim::ActionLog.create!(
            organization: organization,
            action: "update",
            resource: organization,
            user: user,
            version_id: 1000
          )
        end

        it "retrieve actions" do
          expect(Decidim::Ludens::ParticipativeActionCompleted.where(user: user).count).to eq(0)
          subject_class.retrieve_actions
          expect(user.participative_actions_score).to eq(1)
          expect(Decidim::Ludens::ParticipativeActionCompleted.where(user: user).count).to eq(1)
        end
      end

      describe "#remove_unregistered_actions" do
        before do
          Decidim::Ludens::ParticipativeActionCompleted.create!(
            user: user,
            decidim_participative_action: "deliver.Decidim::Organization"
          )
        end

        it "remove unregistered actions" do
          expect(Decidim::Ludens::ParticipativeActionCompleted.where(user: user).count).to eq(1)
          subject_class.remove_unregistered_actions
          expect(Decidim::Ludens::ParticipativeActionCompleted.where(user: user).count).to eq(0)
        end
      end
    end
  end
end
