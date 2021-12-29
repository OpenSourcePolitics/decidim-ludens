module Decidim
  module ParticipativeAssistant
    class ParticipativeAction < ApplicationRecord
      self.table_name = 'decidim_participative_actions'

      belongs_to :organization,
                 foreign_key: "decidim_organization_id",
                 class_name: "Decidim::Organization"

      validates :organization, presence: true


      scope :recommendations, ->{ParticipativeAction.where(completed:false).order(:points).limit(3)}

      def self.lastDoneRecommendations
        last = Decidim::Organization.first.assistant['last']
        ParticipativeAction.find_by(id: last)
      end

      def self.palierScores
        paliers = []

        (1..5).each do |i|
          if i == 1
            paliers.append(ParticipativeAction.where(points: i).size)
          else
            paliers.append(ParticipativeAction.where(points: i).size * i + paliers[i - 2])
          end
        end

        return paliers
      end
    end
  end
end
