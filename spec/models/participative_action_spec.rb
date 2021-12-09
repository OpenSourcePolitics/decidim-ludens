# frozen_string_literal: true

require "spec_helper"

module Decidim
  module ParticipativeAssistant
    describe ParticipativeAction do
      subject { described_class }

      describe ".recommendations" do
        let!(:participative_actions) { create_list(:participative_action, 5) }

        it "returns 3 participative actions ordered by points number" do
          expect(subject.recommendations.size).to eq(3)
          expect(subject.recommendations.first).to eq(participative_actions.first)
          expect(subject.recommendations.last).to eq(participative_actions[2])
        end

        context "when participative actions are completed" do
          let!(:participative_actions) { create_list(:participative_action, 5, :completed, points: 0) }

          it "is not included in the query" do
            expect(subject.recommendations.size).to eq(0)
          end
        end
      end

      describe ".lastDoneRecommendations" do
        let!(:organization) { create(:organization) }
        let!(:participative_action) { create(:participative_action) }

        before do
          organization.assistant["last"] = participative_action.id
          organization.save!
        end

        it "returns participative action id" do
          expect(subject.lastDoneRecommendations).to eq(participative_action)
        end
      end

      describe ".palierScores" do
        let!(:participative_actions) do
          create_list(:participative_action, 2, :completed, points: 1)
          create_list(:participative_action, 3, :completed, points: 2)
          create_list(:participative_action, 5, :completed, points: 3)
          create_list(:participative_action, 1, :completed, points: 4)
          create_list(:participative_action, 4, :completed, points: 5)
        end

        it "returns palierScores" do
          expect(subject.palierScores).to eq([2, 8, 23, 27, 47])
        end
      end
    end
  end
end

