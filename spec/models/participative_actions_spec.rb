# frozen_string_literal: true

require "spec_helper"

module Decidim::Ludens
  describe ParticipativeActions do
    subject { Decidim::Ludens::ParticipativeActions.instance }

    describe "#initialize" do
      it "returns the participative action" do
        expect(subject.actions).not_to be_empty
      end

      it "is stored successfully" do
        expect(subject.actions.first).to be_a(Decidim::Ludens::ParticipativeActions::ParticipativeAction)
      end
    end

    describe "#find" do
      it "returns the participative action" do
        expect(subject.find("answer", "Decidim::Proposals::Proposal")).to be_a(Decidim::Ludens::ParticipativeActions::ParticipativeAction)
        expect(subject.find("answer", "Decidim::Proposals::Proposal").build_id).to eq("answer.Decidim::Proposals::Proposal")
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

    describe "ParticipativeAction" do
      describe "#initialize" do
        it "fill the fields correctly" do
          expect(subject.actions.first.points).to be_a(Integer)
          expect(subject.actions.first.action).to be_a(String)
          expect(subject.actions.first.resource.constantize).to be_a(Class)
          expect(subject.actions.first.category).to be_a(String)
          expect(subject.actions.first.recommendation).to be_a(String)
          expect(subject.actions.first.documentation).to be_a(String)
        end
      end

      describe "#build_id" do
        it "returns a unique id based on the action and the resource" do
          expect(subject.actions.first.build_id).to eq("publish.Decidim::Assembly")
        end
      end

      describe "#completed?" do
        let!(:user) { create(:user) }
        let!(:action) { create(:participative_action_completed, decidim_participative_action: "publish.Decidim::Assembly", user: user) }

        it "returns true if the action is completed" do
          expect(subject.find("publish", "Decidim::Assembly")).to be_completed(user)
        end

        it "returns false if the action is not completed" do
          expect(subject.find("publish", "Decidim::Assembly")).not_to be_completed(create(:user))
        end
      end

      describe "#translated_recommendation" do
        it "returns the translated recommendation" do
          expect(subject.actions.first.translated_recommendation).to be_a(String)
        end
      end
    end
  end
end
