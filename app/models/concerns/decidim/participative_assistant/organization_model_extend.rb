
# frozen_string_literal: true
require "active_support/concern"
module Decidim
  module ParticipativeAssistant
    module OrganizationModelExtend
      extend ActiveSupport::Concern

      included do
        def score
          self.assistant.fetch("score",0)
        end

        def level
          if(ParticipativeAction.where(organization:self).first!=nil)
            paliers = palierScores
            case(score)
              when 0..paliers[0]-1
                1
              when paliers[0]..paliers[1]-1
                2
              when paliers[1]..paliers[2]-1
                3
              when paliers[2]..paliers[3]-1
                4
              else
                5
            end
          else
            5
          end
        end

        def increase_score(points)
          score + points
        end

        def palierScores
          paliers = []

          (1..5).each do |i|
            if i == 1
              paliers.append(ParticipativeAction.where(points: i, organization: self).size)
            else
              paliers.append(ParticipativeAction.where(points: i, organization: self).size * i + paliers[i - 2])
            end
          end

          return paliers
        end
      end
    end
  end
end

