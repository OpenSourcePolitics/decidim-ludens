# frozen_string_literal: true

require "spec_helper"

module Decidim::Ludens
  describe ParticipativeActionCompleted do
    subject { pac }

    let(:p_action) { Decidim::Ludens::ParticipativeActions.instance.actions.first }
    let(:p_action_id) { p_action.build_id }
    let(:user) { create :user }
    let(:pac) { build :participative_action_completed, decidim_participative_action: p_action_id, user: user }

    it { is_expected.to be_valid }

    context "without a user" do
      let(:user) { nil }

      it { is_expected.not_to be_valid }
    end

    context "without a participative action" do
      let(:p_action_id) { nil }

      it { is_expected.not_to be_valid }
    end

    context "when the action already exists" do
      before do
        create :participative_action_completed, decidim_participative_action: p_action.build_id, user: user
      end

      it { is_expected.not_to be_valid }
    end

    describe "#participative_action" do
      it "returns the participative action" do
        expect(subject.participative_action).to eq(p_action)
      end
    end
  end
end
