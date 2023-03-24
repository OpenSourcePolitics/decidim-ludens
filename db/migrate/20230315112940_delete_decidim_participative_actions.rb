# frozen_string_literal: true

class DeleteDecidimParticipativeActions < ActiveRecord::Migration[6.0]
  def change
    drop_table :decidim_participative_actions
  end
end
