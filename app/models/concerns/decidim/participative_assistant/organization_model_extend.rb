
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
          return 4
        end

      end
    end
  end
end

