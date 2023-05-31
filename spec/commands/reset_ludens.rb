# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Ludens
    describe ResetLudens do
      subject { described_class.new(user) }

      let(:organization) { create :organization }
      let(:user) { create :user, :admin, :confirmed, organization: organization }
      let!(:pac1) { create(:participative_action_completed, user: user, decidim_participative_action: "create.Decidim::Blogs::Post") }
      let!(:pac2) { create(:participative_action_completed, user: user, decidim_participative_action: "update.Decidim::Meetings::Agenda") }

      it "resets ludens" do
        expect(Decidim::Ludens::ParticipativeActionCompleted.where(user: user).count).to eq(2)
        subject.call
        expect(Decidim::Ludens::ParticipativeActionCompleted.where(user: user).count).to eq(0)
      end

      it "broadcasts ok" do
        expect do
          subject.call
        end.to broadcast(:ok)
      end
    end
  end
end
