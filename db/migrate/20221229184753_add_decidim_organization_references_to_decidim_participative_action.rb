# frozen_string_literal: true

class AddDecidimOrganizationReferencesToDecidimParticipativeAction < ActiveRecord::Migration[6.0]
  def up
    add_reference :decidim_participative_actions, :decidim_organization, null: false, foreign_key: true
    Decidim::Ludens::ParticipativeAction.where(organization: nil)
                                        .find_each { |pa| pa.update!(organization: Decidim::Organization.first) }
  end

  def down
    remove_reference :decidim_participative_actions, :decidim_organization
  end
end
