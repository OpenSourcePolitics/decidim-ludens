# frozen_string_literal: true

require "active_support/concern"
module Decidim
  module Ludens
    module OrganizationModelExtend
      extend ActiveSupport::Concern

      included do
        def score
          assistant.fetch("score", 0)
        end

        def level
          if !ParticipativeAction.find_by(organization: self).nil?
            paliers = step_scores
            case score
            when 0..paliers[0] - 1
              1
            when paliers[0]..paliers[1] - 1
              2
            when paliers[1]..paliers[2] - 1
              3
            when paliers[2]..paliers[3] - 1
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

        def step_scores
          paliers = []

          (1..5).each do |i|
            if i == 1
              paliers.append(ParticipativeAction.where(points: i, organization: self).size)
            else
              paliers.append(ParticipativeAction.where(points: i, organization: self).size * i + paliers[i - 2])
            end
          end

          paliers
        end
      end
    end
  end
end
