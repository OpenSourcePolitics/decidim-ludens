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

  context 'when there is no participative action' do
    it "doesn't returns a grid of actions" do
      within '.actions-grid' do
        expect(page).not_to have_content('Edition')
        expect(page).not_to have_content('Collaboration')
        expect(page).not_to have_content('Interaction')
        expect(page).not_to have_content('Configuration')
      end
    end

    it 'displays recommendations' do
      expect(page).not_to have_css('.assistant_recommendations')
    end

    it 'displays level 1' do
      within '.assistant_container' do
        expect(page).to have_content('Niveau 5')
        expect(page).to have_content('0/0')
      end
    end
  end

  context 'when there is multiple type of participative actions' do
    let!(:edition_participative_action) { create(:participative_action) }
    let!(:collaboration_participative_action) { create(:participative_action, :collab) }
    let!(:interaction_participative_action) { create(:participative_action, :interact) }
    let!(:configuration_participative_action) { create(:participative_action, :config) }

    it 'returns a grid of actions' do
      # TODO: understand why current_path is needed
      visit current_path

      within '.actions-grid' do
        expect(page).to have_content('Edition')
        expect(page).to have_content('Collaboration')
        expect(page).to have_content('Interaction')
        expect(page).to have_content('Configuration')
      end
    end
  end

  # TODO: Refactor tests below
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

    context 'when some participative actions are completed' do
      let!(:participative_actions) do
        create_list(:participative_action, 4, :collab)
        create_list(:participative_action, 3, :completed, :collab)
      end

      it 'displays all actions' do
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

    context 'when participative actions are all completed' do
      let!(:participative_actions) do
        create_list(:participative_action, 3, :completed, :collab)
      end

      it 'displays all actions' do
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

  context 'when there is more than 5 participative action' do
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

    context 'when some participative actions are completed' do
      let!(:participative_actions) do
        create_list(:participative_action, 6, :collab)
        create_list(:participative_action, 8, :completed, :collab)
      end

      it 'displays all actions' do
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

    context 'when participative actions are all completed' do
      let!(:participative_actions) do
        create_list(:participative_action, 9, :completed, :collab)
      end

      it 'displays all actions' do
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
