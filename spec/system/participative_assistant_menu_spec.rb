# frozen_string_literal: true

require "spec_helper"

describe "Participative assistant menu", type: :system do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization: organization) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin_participative_assistant.root_path
  end

  describe "menu" do
    it "can be clicked" do
      within "nav" do
        click_link "Participative Assistant"
      end

      within "h1.card-title" do
        expect(page).to have_content("Participative Assistant")
      end
    end
  end
end
