# frozen_string_literal: true

class DeleteLudensColumnsFromOrganizations < ActiveRecord::Migration[6.0]
  def up
    remove_column :decidim_organizations, :assistant
    remove_column :decidim_organizations, :enable_ludens
  end

  def down
    add_column :decidim_organizations, :assistant, :jsonb
    add_column :decidim_organizations, :enable_ludens, :boolean, default: false
  end
end
