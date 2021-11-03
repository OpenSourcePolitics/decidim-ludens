class AddAssistantToOrganization < ActiveRecord::Migration[6.0]
  def up
    add_column :decidim_organization, :assistant, :jsonb
  end
  def down
    remove_column :decidim_organization, :assistant
  end
end
