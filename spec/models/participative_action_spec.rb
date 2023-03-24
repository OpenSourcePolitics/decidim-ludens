# frozen_string_literal: true

require "spec_helper"

module Decidim::Ludens
  describe ParticipativeAction do
    subject { described_class }

    let(:p_action) { Decidim::Ludens::ParticipativeAction.actions.first }
    let(:p_action_id) { p_action.global_id }
    let(:user) { create :user }
    let(:pac) { [build(:participative_action_completed, decidim_participative_action: p_action_id, user: user)] }

    describe ".actions" do
      it "returns the participative action" do
        expect(subject.actions).not_to be_empty
      end

      it "is stored successfully" do
        expect(subject.actions.first).to be_a(Decidim::Ludens::ParticipativeAction)
      end
    end

    describe "#find" do
      it "returns the participative action" do
        expect(subject.find("answer.Decidim::Proposals::Proposal")).to be_a(Decidim::Ludens::ParticipativeAction)
        expect(subject.find("answer.Decidim::Proposals::Proposal").global_id).to eq("answer.Decidim::Proposals::Proposal")
      end
    end

    describe "#level_points" do
      it "returns the step to level up" do
        expect(subject.level_points.size).to eq(5)
        expect(subject.level_points.sort).to eq(subject.level_points)
      end
    end

    describe "#list_of_participative_actions" do
      context "when all actions are uncompleted" do
        it "returns the list of participative actions, all uncompleted" do
          expect(subject.list_of_participative_actions(create(:user))).not_to be_empty
          expect(subject.list_of_participative_actions(create(:user)).values.first[:completed]).to be_empty
        end
      end

      context "when an action is completed" do
        let!(:user) { create(:user) }
        let!(:action) { create(:participative_action_completed, decidim_participative_action: "publish.Decidim::Assembly", user: user) }

        it "returns the list of participative actions, with one completed" do
          expect(subject.list_of_participative_actions(user)[:edition][:completed]).to eq([action.participative_action])
        end
      end
    end

    describe "#global_id" do
      it "returns a unique id based on the action and the resource" do
        expect(subject.actions.first.global_id).to eq("publish.Decidim::Assembly")
      end
    end

    describe "#translated_recommendation" do
      it "returns the translated recommendation" do
        expect(subject.actions.first.translated_recommendation).to be_a(String)
      end
    end

    describe ".recommendations" do
      it "returns the recommendations" do
        expect(subject.recommendations(pac).size).to eq(3)
        expect(subject.recommendations(pac).first.points).to eq(1)
      end
    end

    describe ".remaining_actions" do
      it "returns the remaining_actions" do
        expect(subject.remaining_actions(pac).size).to eq(67)
        expect(subject.remaining_actions(pac).first.points).to eq(1)
      end
    end
  end
end
