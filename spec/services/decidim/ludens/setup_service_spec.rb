# frozen_string_literal: true

require "spec_helper"

describe Decidim::Ludens::SetupService do
  subject { described_class.new(organization) }

  let(:organization) { create(:organization, assistant: nil) }
  let(:subject_class) { described_class }

  def get_em(hash)
    hash.each_with_object([]) do |(k, v), keys|
      keys << k
      keys.concat(get_em(v)) if v.is_a? Hash
    end
  end

  describe "ACTIONS" do
    it "contains all keys for each entry" do
      keys = get_em(Decidim::Ludens::SetupService::ACTIONS["actions"])
      expect(keys.tally["recommendation"]).to eq(keys.tally["points"])
      expect(keys.tally["documentation"]).to eq(keys.tally["points"])
    end
  end

  describe ".initialize_assistant" do
    context "when tables does not exists" do
      before do
        allow(Decidim::Organization).to receive(:table_exists?).and_return(false)
        allow(Decidim::Ludens::ParticipativeAction).to receive(:table_exists?).and_return(false)
      end

      it "raises a runtime error with message" do
        expect { subject_class.initialize_assistant }.to raise_error("Unknown table Organization or Participative action, please run migration first")
      end
    end
  end

  describe "#create_assistant" do
    it "initialize the assistant" do
      expect { subject.create_assistant }.to change(organization, :assistant)
    end

    it "returns a setup service instance" do
      expect(subject.create_assistant).to be_an_instance_of(Decidim::Ludens::SetupService)
    end

    context "when assistant as already been initialized" do
      let(:organization) { create(:organization) }

      it "doesn't initialize the assistant" do
        expect { subject.create_assistant }.not_to change(organization, :assistant)
      end

      it "returns a setup service instance" do
        expect(subject.create_assistant).to be_an_instance_of(Decidim::Ludens::SetupService)
      end
    end
  end

  describe "#create_actions" do
    it "creates actions" do
      expect { subject.create_actions }.to change(Decidim::Ludens::ParticipativeAction, :count).by(get_em(Decidim::Ludens::SetupService::ACTIONS["actions"]).tally["recommendation"])
    end

    context "when participative action already exists" do
      before do
        Decidim::Ludens::ParticipativeAction.find_or_create_by!(
          points: 1,
          resource: "Decidim::Assembly",
          action: "publish",
          category: "Edition",
          organization: organization,
          recommendation: "Publish an assembly",
          documentation: "https://docs-decidim.opensourcepolitics.eu/article/94-lespace-assemblees"
        )
      end

      it "doesn't create an action" do
        expect { subject.create_actions }.to change(Decidim::Ludens::ParticipativeAction, :count).by(get_em(Decidim::Ludens::SetupService::ACTIONS["actions"]).tally["recommendation"])
      end
    end
  end
end
