# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Ludens
    module Admin
      describe LudensController, type: :controller do
        routes { Decidim::Ludens::AdminEngine.routes }

        let(:organization) { create(:organization) }
        let(:organization2) { create(:organization) }
        let(:current_user) { create(:user, :admin, :confirmed, organization: organization) }

        before do
          request.env["decidim.current_organization"] = organization
          sign_in current_user, scope: :user
        end

        describe "SHOW" do
          it "responds with show" do
            get :show
            expect(response).to render_template("show")
          end
        end

        describe "#list_of_participative_actions" do
          it "returns an openstruct" do
            expect(subject.list_of_participative_actions.class).to be(Hash)
          end

          it "returns an empty tree of participative actions" do
            expect(subject.list_of_participative_actions).to eq({})
          end

          context "when there is edition actions" do
            let!(:uncompleted_edition_actions) { create_list(:participative_action, 3, organization: organization) }
            let!(:other_org_actions) { create_list(:participative_action, 3, organization: organization2) }

            it "returns the edition actions in a tree of participative actions" do
              expect(subject.list_of_participative_actions).to eq({
                                                                    edition: {
                                                                      uncompleted: uncompleted_edition_actions,
                                                                      completed: []
                                                                    }
                                                                  })
            end

            context "when actions are completed" do
              let!(:completed_edition_actions) { create_list(:participative_action, 3, :completed, organization: organization) }

              it "returns the edition actions in a tree of participative actions" do
                expect(subject.list_of_participative_actions).to eq({
                                                                      edition: {
                                                                        uncompleted: uncompleted_edition_actions,
                                                                        completed: completed_edition_actions
                                                                      }
                                                                    })
              end
            end
          end

          context "when there is multiples actions" do
            let!(:uncompleted_edition_actions) { create_list(:participative_action, 3, organization: organization) }
            let!(:uncompleted_interact_actions) { create_list(:participative_action, 3, :interact, organization: organization) }
            let!(:completed_edition_actions) { create_list(:participative_action, 3, :completed, organization: organization) }
            let!(:completed_interact_actions) { create_list(:participative_action, 3, :completed, :interact, organization: organization) }
            let!(:other_org_actions) { create_list(:participative_action, 3, organization: organization2) }

            it "returns the actions tree of participative actions" do
              expect(subject.list_of_participative_actions).to eq({
                                                                    edition: {
                                                                      uncompleted: uncompleted_edition_actions,
                                                                      completed: completed_edition_actions
                                                                    },
                                                                    interaction: {
                                                                      uncompleted: uncompleted_interact_actions,
                                                                      completed: completed_interact_actions
                                                                    }
                                                                  })
            end
          end
        end
      end
    end
  end
end
