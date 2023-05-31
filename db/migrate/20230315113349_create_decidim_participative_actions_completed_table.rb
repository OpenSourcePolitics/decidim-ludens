# frozen_string_literal: true

class CreateDecidimParticipativeActionsCompletedTable < ActiveRecord::Migration[6.0]
  def change
    create_table :participative_actions_completed do |t|
      t.string :decidim_participative_action, null: false
      t.references :decidim_user, null: false, foreign_key: true
    end
  end
end
