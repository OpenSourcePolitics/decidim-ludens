# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Ludens
    describe ParticipativeAction do
      subject { described_class }

      describe ".recommendations" do
        let!(:organization) { create(:organization) }

        context "when there's just one of each points" do
          let!(:participative_actions) { create_list(:participative_action, 5, organization: organization) }

          it "returns 3 random participative actions ordered by points number" do
            expect(subject.recommendations.size).to eq(3)
            expect(subject.recommendations.first).to eq(participative_actions.first)
            expect(subject.recommendations.last).to eq(participative_actions[2])
          end
        end

        context "when there are multiple ones" do
          let!(:participative_action1) { create(:participative_action, points: 1, organization: organization) }
          let!(:participative_action2) { create(:participative_action, points: 1, organization: organization) }
          let!(:participative_action3) { create(:participative_action, points: 2, organization: organization) }
          let!(:participative_action4) { create(:participative_action, points: 2, organization: organization) }
          let!(:participative_action5) { create(:participative_action, points: 2, organization: organization) }

          it "returns 3 random participative actions ordered by points number" do
            expect(subject.recommendations.size).to eq(3)
            expect(subject.recommendations.first.points).to eq(1)
            expect(subject.recommendations[1].points).to eq(1)
            expect(subject.recommendations.last.points).to eq(2)
          end
        end

        context "when participative actions are completed" do
          let!(:participative_actions) { create_list(:participative_action, 5, :completed, points: 1, organization: organization) }

          it "is not included in the query" do
            expect(subject.recommendations.size).to eq(0)
          end
        end
      end

      describe ".lastDoneRecommendations" do
        let!(:organization) { create(:organization) }
        let!(:participative_action) { create(:participative_action, organization: organization) }

        before do
          organization.assistant["last"] = participative_action.id
          organization.save!
        end

        it "returns participative action id" do
          expect(subject.last_done_recommendation).to eq(participative_action)
        end
      end

      describe ".translated_recommendation" do
        let!(:organization) { create(:organization) }
        let!(:participative_action) { create(:participative_action, organization: organization, recommendation: "publish.componentTest") }

        before do
          allow(I18n).to receive(:t).with("decidim.ludens.actions.publish.componentTest").and_return("okay")
        end

        it "returns the recommendation translated" do
          expect(participative_action.translated_recommendation).to eq("okay")
        end
      end

      describe "plusieurs organisations" do
        let!(:organization1) { create(:organization) }
        let!(:organization2) { create(:organization) }
        let!(:participative_actions1) do
          create_list(:participative_action, 2, :completed, points: 1, organization: organization1)
          create_list(:participative_action, 3, :completed, points: 2, organization: organization1)
          create_list(:participative_action, 5, :completed, points: 3, organization: organization1)
          create_list(:participative_action, 1, :completed, points: 4, organization: organization1)
          create_list(:participative_action, 4, :completed, points: 5, organization: organization1)
        end
        let!(:participative_actions2) do
          create_list(:participative_action, 4, :completed, points: 1, organization: organization2)
          create_list(:participative_action, 1, :completed, points: 2, organization: organization2)
          create_list(:participative_action, 2, :completed, points: 3, organization: organization2)
          create_list(:participative_action, 5, :completed, points: 4, organization: organization2)
          create_list(:participative_action, 3, :completed, points: 5, organization: organization2)
        end

        it "returns the good palierScores" do
          expect(organization1.step_scores).to eq([2, 8, 23, 27, 47])
          expect(organization2.step_scores).to eq([4, 6, 12, 32, 47])
        end
      end
    end
  end
end
