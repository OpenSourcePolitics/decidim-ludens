# frozen_string_literal: true

require "spec_helper"

module Decidim
  module ParticipativeAssistant
    describe ParticipativeAction do
      subject { described_class }
      describe ".recommendations" do

        let!(:participative_actions) { create_list(:participative_action,5) }

        it "returns 3 participative actions ordered by points number" do
          expect(subject.recommendations.size).to eq(3)
          expect(subject.recommendations.first).to eq(participative_actions.first)
          expect(subject.recommendations.last).to eq(participative_actions[2])
       end

        context "when participative actions are completed" do

          let!(:participative_actions) { create_list(:participative_action,5,:completed,points: 0) }

          it "is not included in the query" do
            expect(subject.recommendations.size).to eq(0)

          end
        end

      end
      
    end
  end
end

