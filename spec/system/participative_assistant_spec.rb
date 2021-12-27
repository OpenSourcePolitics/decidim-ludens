# frozen_string_literal: true

require 'spec_helper'

describe 'Participative assistant', type: :system do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization: organization) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin_participative_assistant.root_path
  end

  shared_examples "a participative action grid" do
    no_contents_grid.each do |content|
      expect(page).not_to have_content(content)
    end

    contents_grid.each do |content|
      expect(page).to have_content(content)
    end
  end

  context 'when there is no participative action' do
    let(:no_contents_grid) { ["Edition", "Collaboration", "Interaction", "Configuration"] }
    let(:contents_grid) { [] }

    it_behaves_like "a participative action grid"

    it "displays recommendations" do
      expect(page).not_to have_css(".assistant_recommendations")
    end

    it 'displays level 1' do
      within '.assistant_container' do
        expect(page).to have_content('Niveau 5')
        expect(page).to have_content('0/0')
      end
    end
  end

  context 'when there is less than 5 participative action in each' do
    context 'when participative actions are all uncompleted' do

      let!(:participative_actions) do
        create_list(:participative_action, 4, :collab)
      end

      it 'displays actions uncompleted' do
        within '.card-Collaboration .list-actions-completed' do
          expect(page).not_to have_content(' ')
        end

        within '.card-Collaboration .list-actions-uncompleted' do
          expect(page).to have_content(' ')
        end

        within '.card-Collaboration' do
          click_link 'See all'
        end

        within '#exampleModalCollaboration .list-actions-completed' do
          expect(page).not_to have_content(' ')
        end

        within '#exampleModalCollaboration .list-actions-uncompleted' do
          expect(page).to have_content(' ')
        end

      end
    end

    context "when some participative actions are completed" do

      let!(:participative_actions) do
        create_list(:participative_action, 4, :collab)
        create_list(:participative_action, 3, :completed, :collab)
      end

      it "displays all actions" do
        within '.card-Collaboration .list-actions-completed' do
          expect(page).to have_content(' ')
        end

        within '.card-Collaboration .list-actions-uncompleted' do
          expect(page).to have_content(' ')
        end

        within '.card-Collaboration' do
          click_link 'See all'
        end

        within '#exampleModalCollaboration .list-actions-completed' do
          expect(page).to have_content(' ')
        end

        within '#exampleModalCollaboration .list-actions-uncompleted' do
          expect(page).to have_content(' ')
        end
      end
    end

    context "when participative actions are all completed" do

      let!(:participative_actions) do
        create_list(:participative_action, 3, :completed, :collab)
      end

      it "displays all actions" do
        within '.card-Collaboration .list-actions-completed' do
          expect(page).to have_content(' ')
        end

        within '.card-Collaboration .list-actions-uncompleted' do
          expect(page).not_to have_content(' ')
        end

        within '.card-Collaboration' do
          click_link 'See all'
        end

        within '#exampleModalCollaboration .list-actions-completed' do
          expect(page).to have_content(' ')
        end

        within '#exampleModalCollaboration .list-actions-uncompleted' do
          expect(page).not_to have_content(' ')
        end
      end
    end
  end

  context "when there is more than 5 participative action" do
    context 'when participative actions are all uncompleted' do

      let!(:participative_actions) do
        create_list(:participative_action, 7, :collab)
      end

      it 'displays actions uncompleted' do
        within '.card-Collaboration .list-actions-completed' do
          expect(page).not_to have_content(' ')
        end

        within '.card-Collaboration .list-actions-uncompleted' do
          expect(page).to have_content(' ')
        end

        within '.card-Collaboration' do
          click_link 'See all'
        end

        within '#exampleModalCollaboration .list-actions-completed' do
          expect(page).not_to have_content(' ')
        end

        within '#exampleModalCollaboration .list-actions-uncompleted' do
          expect(page).to have_content(' ')
        end

      end
    end

    context "when some participative actions are completed" do

      let!(:participative_actions) do
        create_list(:participative_action, 6, :collab)
        create_list(:participative_action, 8, :completed, :collab)
      end

      it "displays all actions" do
        within '.card-Collaboration .list-actions-completed' do
          expect(page).to have_content(' ')
        end

        within '.card-Collaboration .list-actions-uncompleted' do
          expect(page).to have_content(' ')
        end

        within '.card-Collaboration' do
          click_link 'See all'
        end

        within '#exampleModalCollaboration .list-actions-completed' do
          expect(page).to have_content(' ')
        end

        within '#exampleModalCollaboration .list-actions-uncompleted' do
          expect(page).to have_content(' ')
        end
      end
    end

    context "when participative actions are all completed" do

      let!(:participative_actions) do
        create_list(:participative_action, 9, :completed, :collab)
      end

      it "displays all actions" do
        within '.card-Collaboration .list-actions-completed' do
          expect(page).to have_content(' ')
        end

        within '.card-Collaboration .list-actions-uncompleted' do
          expect(page).not_to have_content(' ')
        end

        within '.card-Collaboration' do
          click_link 'See all'
        end

        within '#exampleModalCollaboration .list-actions-completed' do
          expect(page).to have_content(' ')
        end

        within '#exampleModalCollaboration .list-actions-uncompleted' do
          expect(page).not_to have_content(' ')
        end
      end
    end
  end
end
