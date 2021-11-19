
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
          case(score)
          when 0..5
            1
          when 6..15
            2
          when 16..27
            3
          when 28..39
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

