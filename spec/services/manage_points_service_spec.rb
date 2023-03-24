# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Ludens
    describe ManagePoints do
      subject { described_class }

      let(:organization) { create :organization }
      let(:user) { create :user, organization: organization, current_sign_in_ip: "127.0.0.1" }
      let(:participatory_space) { create :participatory_process, organization: organization }
      let(:component) { create :component, participatory_space: participatory_space }
      let(:resource) { create :dummy_resource, component: component }
      let(:action) { "create" }
      let(:subject_run) { subject.new(action, user, resource).run }

      describe ".run" do
        context "when participative action doesn't exist" do
          let!(:resource) { create :user }

          it "returns nil" do
            expect(subject_run).to eq(nil)
          end
        end

        context "when participative action is already completed" do
          let!(:resource) { create :participatory_process, organization: organization }
          let!(:participative_action) { create :participative_action_completed, decidim_participative_action: "create.Decidim::ParticipatoryProcess", user: user }

          it "returns nil" do
            expect(subject_run).to eq(nil)
          end
        end

        context "when participative action is present" do
          let!(:resource) { create :participatory_process, organization: organization }
          let!(:cache_store) { :memory_store }

          before do
            allow(Rails).to receive(:cache).and_return(ActiveSupport::Cache.lookup_store(cache_store))
            Rails.cache.clear
          end

          it "completes organization" do
            subject_run
            expect(ParticipativeActionCompleted.last.participative_action.global_id).to eq("create.Decidim::ParticipatoryProcess")
            expect(Rails.cache.read("flash_message_#{user.id}")).to eq("Congratulations ! You just completed the action 'Create a participatory process' !")
          end
        end
      end
    end
  end
end
