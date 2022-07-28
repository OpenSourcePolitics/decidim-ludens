# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Ludens
    describe ParticipativeAction do
      subject { described_class }

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
    end
  end
end
