# frozen_string_literal: true

module Decidim
  module Ludens
    class ParticipativeAction < ApplicationRecord
      self.table_name = "decidim_participative_actions"

      belongs_to :organization,
                 foreign_key: "decidim_organization_id",
                 class_name: "Decidim::Organization"

      validates :organization, presence: true

      def self.last_done_recommendation
        last = Decidim::Organization.first.assistant["last"]
        ParticipativeAction.find_by(id: last)
      end

      def self.recommendations
        actions = ParticipativeAction.where(completed: [false, nil]).order(:points).group_by(&:points)
        actions = actions.each { |key, value| actions[key] = value.shuffle }
        actions.values.flatten[0, 3]
      end
    end
  end
end
