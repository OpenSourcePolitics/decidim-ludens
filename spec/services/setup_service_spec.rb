#frozen_string_literal: true

require "spec_helper"

describe Decidim::ParticipativeAssistant::SetupService do

  let(:organization) { create(:organization, assistant: nil) }

  subject { described_class.new(organization) }
  let(:subject_class) { described_class }

  let(:actions) {
    [
      {
        points: 3,
        resource: "Decidim::Assembly",
        action: "publish",
        category: "Edition",
        recommendation: "Publish an assembly",
        organization: organization,
        documentation: "#"
      }
    ]
  }

  describe "ACTIONS" do
    it "contains all keys for each entry" do
      count = Decidim::ParticipativeAssistant::SetupService::ACTIONS.count
      keys = Decidim::ParticipativeAssistant::SetupService::ACTIONS.map(&:keys).flatten

      expect(keys.tally).to eq({
                                 points: count,
                                 resource: count,
                                 action: count,
                                 category: count,
                                 recommendation: count,
                                 documentation: count
                               })
    end
  end

  describe ".initialize_assistant" do
    context "if tables does not exists" do
      before do
        allow(Decidim::Organization).to receive(:table_exists?).and_return(false)
        allow(Decidim::ParticipativeAssistant::ParticipativeAction).to receive(:table_exists?).and_return(false)
      end

      it "raises a runtime error with message" do
        expect{subject_class.initialize_assistant}.to raise_error("Unknown table Organization or Participative action, please run migration first")
      end
    end
  end

  describe "#create_assistant" do
    it "initialize the assistant" do
      expect { subject.create_assistant }.to change{organization.assistant}
    end

    it "returns a setup service instance" do
      expect(subject.create_assistant).to be_an_instance_of(Decidim::ParticipativeAssistant::SetupService)
    end

    context "when assistant as already been initialized" do
      let(:organization) { create(:organization) }

      it "doesn't initialize the assistant" do
        expect { subject.create_assistant }.not_to change{organization.assistant}
      end

      it "returns a setup service instance" do
        expect(subject.create_assistant).to be_an_instance_of(Decidim::ParticipativeAssistant::SetupService)
      end
    end
  end

  describe "#create_actions" do
    it "creates an action" do
      expect { subject.create_actions }.to change(Decidim::ParticipativeAssistant::ParticipativeAction, :count).by(1)
    end

    context "when participative action already exists" do
      before do
        Decidim::ParticipativeAssistant::ParticipativeAction.find_or_create_by!(
          points: 3,
          resource: "Decidim::Assembly",
          action: "publish",
          category: "Edition",
          organization: organization,
          recommendation: "Publish an assembly",
          documentation: "#"
        )
      end

      it "doesn't create an action" do
        expect { subject.create_actions }.not_to change(Decidim::ParticipativeAssistant::ParticipativeAction, :count)
      end
    end
  end
end
