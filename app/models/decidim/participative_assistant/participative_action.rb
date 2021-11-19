module Decidim
  module ParticipativeAssistant
    class ParticipativeAction < ApplicationRecord
      self.table_name="decidim_participative_actions"

      def self.recommendations
        ParticipativeAction.where(completed:FALSE).order(:points).limit(3)
      end
    end
  end
end
