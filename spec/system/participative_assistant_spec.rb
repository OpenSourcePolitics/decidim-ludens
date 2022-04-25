# frozen_string_literal: true

require "spec_helper"

describe "Participative assistant", type: :system do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization: organization) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin_participative_assistant.root_path
  end

  context "when there is no participative action" do
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
        expect(page).to have_content("Level 5")
        expect(page).to have_content("0/0")
      end
    end
  end

  context "when there is multiple type of participative actions" do
    let!(:edition_participative_action) { create(:participative_action, organization: organization) }
    let!(:collaboration_participative_action) { create(:participative_action, :collab, organization: organization) }
    let!(:interaction_participative_action) { create(:participative_action, :interact, organization: organization) }
    let!(:configuration_participative_action) { create(:participative_action, :config, organization: organization) }

    it "returns a grid of actions" do
      # TODO: understand why current_path is needed

      visit current_path

      within ".actions-grid" do
        expect(page).to have_content("Edition")
        expect(page).to have_content("Collaboration")
        expect(page).to have_content("Interaction")
        expect(page).to have_content("Configuration")
      end
    end
  end

  context "when there is less than 5 participative action in each" do
    context "when participative actions are all uncompleted" do
      let!(:participative_actions) do
        create_list(:participative_action, 4, :collab, organization: organization)
      end

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
      let!(:participative_actions) do
        create_list(:participative_action, 4, :collab, organization: organization)
        create_list(:participative_action, 3, :completed, :collab, organization: organization)
      end

      it "displays all actions" do
        visit current_path

        within ".card-Collaboration .list-actions-completed" do
          expect(page).to have_content(" ")
        end

        within ".card-Collaboration .list-actions-uncompleted" do
          expect(page).to have_content(" ")
        end

        find("#openModalCollaboration").click

        within "#exampleModalCollaboration .modal-actions-completed" do
          expect(page).to have_content(" ")
        end

        within "#exampleModalCollaboration .modal-actions-uncompleted" do
          expect(page).to have_content(" ")
        end
      end
    end

    context "when participative actions are all completed" do
      let!(:participative_actions) do
        create_list(:participative_action, 3, :completed, :collab, organization: organization)
      end

      it "displays all actions" do
        visit current_path

        within ".card-Collaboration .list-actions-completed" do
          expect(page).to have_content(" ")
        end

        expect(page).not_to have_css(".card-Collaboration .list-actions-uncompleted li")

        find("#openModalCollaboration").click

        within "#exampleModalCollaboration .modal-actions-completed" do
          expect(page).to have_content(" ")
        end

        expect(page).not_to have_css("#exampleModalCollaboration .modal-actions-uncompleted li")
      end
    end
  end

  context "when there is more than 5 participative action" do
    context "when participative actions are all uncompleted" do
      let!(:participative_actions) do
        create_list(:participative_action, 7, :collab, organization: organization)
      end

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
      let!(:participative_actions) do
        create_list(:participative_action, 6, :collab, organization: organization)
        create_list(:participative_action, 8, :completed, :collab, organization: organization)
      end

      it "displays all actions" do
        visit current_path

        within ".card-Collaboration .list-actions-completed" do
          expect(page).to have_content(" ")
        end

        within ".card-Collaboration .list-actions-uncompleted" do
          expect(page).to have_content(" ")
        end

        find("#openModalCollaboration").click

        within "#exampleModalCollaboration .modal-actions-completed" do
          expect(page).to have_content(" ")
        end

        within "#exampleModalCollaboration .modal-actions-uncompleted" do
          expect(page).to have_content(" ")
        end
      end
    end

    context "when participative actions are all completed" do
      let!(:participative_actions) do
        create_list(:participative_action, 9, :completed, :collab, organization: organization)
      end

      it "displays completed actions" do
        visit current_path

        within ".card-Collaboration .list-actions-completed" do
          expect(page).to have_content(" ")
        end

        expect(page).not_to have_css(".card-Collaboration .list-actions-uncompleted li")

        find("#openModalCollaboration").click

        within "#exampleModalCollaboration .modal-actions-completed" do
          expect(page).to have_content(" ")
        end

        expect(page).not_to have_css("#exampleModalCollaboration .modal-actions-uncompleted li")
      end
    end
  end
end
