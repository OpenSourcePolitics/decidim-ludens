class AddDecidimOrganizationToParticipativeAction < ActiveRecord::Migration[6.0]
  def up
    add_reference :decidim_participative_actions, :decidim_organization, index: true, foreign_key: true

    Decidim::ParticipativeAssistant::ParticipativeAction.where(decidim_organization: nil)
                       .update_all(decidim_organization: Decidim::Organization.first)
  end

  def down
    remove_reference :decidim_participative_actions, :decidim_organization
  end
end
