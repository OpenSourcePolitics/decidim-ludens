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
      end
    end
  end
end
