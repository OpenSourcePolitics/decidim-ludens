# frozen_string_literal: true

require "spec_helper"

module Decidim
  module ParticipativeAssistant
    module Admin
      describe ParticipativeAssistantController, type: :controller do
        routes { Decidim::ParticipativeAssistant::AdminEngine.routes }

        let(:organization) { create(:organization) }
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
            let!(:uncompleted_participative_actions) { create_list(:participative_action, 3) }

            it "returns the edition actions in a tree of participative actions" do
              expect(subject.list_of_participative_actions).to eq({
                                                                    edition: {
                                                                      uncompleted: uncompleted_participative_actions,
                                                                      completed: nil
                                                                    }
                                                                  })
            end

            context "when actions are completed" do
              let!(:completed_participative_actions) { create_list(:participative_action, 3, :completed) }

              it "returns the edition actions in a tree of participative actions" do
                expect(subject.list_of_participative_actions).to eq({
                                                                      edition: {
                                                                        uncompleted: uncompleted_participative_actions,
                                                                        completed: completed_participative_actions
                                                                      }
                                                                    })
              end
            end
          end
        end
      end
    end
  end
end
