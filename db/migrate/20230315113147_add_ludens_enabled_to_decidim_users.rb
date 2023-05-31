# frozen_string_literal: true

class AddLudensEnabledToDecidimUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :decidim_users, :enable_ludens, :boolean
  end

  def down
    remove_column :decidim_users, :enable_ludens
  end
end
