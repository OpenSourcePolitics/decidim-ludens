
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
          paliers=ParticipativeAction.palierScores
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
        end

        def increase_score(points)
          self.assistant["score"]+=points
        end

      end
    end
  end
end

