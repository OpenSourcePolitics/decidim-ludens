# frozen_string_literal: true

require "spec_helper"

describe "Participative assistant action", type: :system do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization: organization) }
  let!(:participative_action) { create(:participative_action, organization: organization, points: 1) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin_participative_assistant.root_path
  end

  context "when there is one participative action" do
    it "can be completed" do
      within ".recap_assistant" do
        expect(page).to have_content("Niveau 1")
        expect(page).to have_content("0/1")
      end

      within ".assistant_recommendations" do
        expect(page).to have_content("1 pts")
        expect(page).to have_content(participative_action.recommendation)
      end

      within "nav" do
        click_link "Assemblies"
      end

      expect(page).to have_content("Assemblies type")

      click_link "New assembly"

      expect(page).to have_content("General Information")

      find("#assembly_title_en").send_keys("Title_new_action")
      find("#assembly_subtitle_en").send_keys("Subitle")
      find("#assembly_weight").send_keys("2")
      find("#assembly_slug").send_keys("sdfghjk")
      find("#assembly-short_description-tabs-short_description-panel-0 .ql-editor").send_keys("Short description")
      find("#assembly-description-tabs-description-panel-0 .ql-editor").send_keys("Really long description")

      click_button "Create"

      expect(page).to have_content("Assembly created successfully")

      click_link "Title_new_action"

      click_link "Publish"

      expect(page).to have_content("Congratulations ! You just completed the action '#{participative_action.recommendation}' !")

      click_link "Dashboard"

      within ".recap_assistant" do
        expect(page).to have_content("Niveau 5")
        expect(page).to have_content("1/1")
      end

      within ".assistant_recommendations .no-bullet" do
        expect(page).to have_content("1 pts")
        expect(page).to have_content(participative_action.recommendation)
      end
    end
  end
end
