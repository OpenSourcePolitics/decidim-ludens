class AddAssistantToOrganization < ActiveRecord::Migration[6.0]
  def up
    add_column :decidim_organizations, :assistant, :jsonb
  end
  def down
    remove_column :decidim_organizations, :assistant
  end
end
