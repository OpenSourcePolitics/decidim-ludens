# frozen_string_literal: true

class AddEnableLudensToOrganization < ActiveRecord::Migration[6.0]
  def up
    add_column :decidim_organizations, :enable_ludens, :boolean, default: false
  end

  def down
    remove_column :decidim_organizations, :enable_ludens
  end
end
