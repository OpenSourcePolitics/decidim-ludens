# frozen_string_literal: true

class CreateDecidimParticipativeActions < ActiveRecord::Migration[6.0]
  def change
    create_table :decidim_participative_actions do |t|
      t.boolean :completed
      t.integer :points
      t.string :resource
      t.string :action
      t.string :category
      t.string :recommendation
    end
  end
end
