# frozen_string_literal: true

require "spec_helper"

describe "Ludens", type: :system do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization: organization) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin_ludens.root_path
  end

  context "when there is no participative action" do
    before do
      allow(Decidim::Ludens::ParticipativeActions.instance).to receive(:actions).and_return([])
      visit current_path
    end

    it "doesn't returns a grid of actions" do
      within ".actions-grid" do
        expect(page).not_to have_content("Edition")
        expect(page).not_to have_content("Collaboration")
        expect(page).not_to have_content("Interaction")
        expect(page).not_to have_content("Configuration")
      end
    end

    it "displays recommendations" do
      expect(page).not_to have_css(".recommendation")
    end

    it "displays level 1" do
      within ".assistant_container" do
        expect(page).to have_content("Level 1")
        expect(page).to have_content("0/0")
      end
    end
  end

  context "when there is multiple type of participative actions" do
    it "returns a grid of actions" do
      within ".actions-grid" do
        expect(page).to have_content("Edition")
        expect(page).to have_content("Collaboration")
        expect(page).to have_content("Interaction")
        expect(page).to have_content("Configuration")
      end
    end
  end

  context "when participative actions are all uncompleted" do
    it "displays actions uncompleted" do
      visit current_path

      expect(page).not_to have_css(".card-Collaboration .list-actions-completed li")

      within ".card-Collaboration .list-actions-uncompleted" do
        expect(page).to have_content(" ")
      end

      find("#openModalCollaboration").click

      expect(page).not_to have_css("#exampleModalCollaboration .modal-actions-completed li")

      within "#exampleModalCollaboration .modal-actions-uncompleted" do
        expect(page).to have_content(" ")
      end
    end
  end

  context "when some participative actions are completed" do
    let!(:pac1) { create(:participative_action_completed, user: user, decidim_participative_action: "create.Decidim::Blogs::Post") }
    let!(:pac2) { create(:participative_action_completed, user: user, decidim_participative_action: "update.Decidim::Meetings::Agenda") }

    it "displays all actions" do
      visit current_path

      within ".card-Edition .list-actions-completed" do
        expect(page).to have_content(pac1.participative_action.translated_recommendation)
        expect(page).to have_content(pac2.participative_action.translated_recommendation)
      end

      find("#openModalEdition").click

      within "#exampleModalEdition .modal-actions-completed" do
        expect(page).to have_content(pac1.participative_action.translated_recommendation)
        expect(page).to have_content(pac2.participative_action.translated_recommendation)
      end

      within "#exampleModalEdition .modal-actions-uncompleted" do
        expect(page).to have_content(Decidim::Ludens::ParticipativeAction.find("create", "Decidim::StaticPage").translated_recommendation)
      end
    end
  end

  context "when you want to deactivate ludens" do
    it "deactivate ludens" do
      click_link "Disable the assistant"

      expect(page).to have_content("Enable the assistant")
    end
  end
end
