# frozen_string_literal: true

require "active_support/concern"

module Decidim
  module ParticipativeAssistant
    module ActionLoggerServiceExtend
      extend ActiveSupport::Concern

      included do
        def self.log(action, user, resource, version_id, resource_extra = {})
          new(action, user, resource, version_id, resource_extra).log!
          Decidim::ParticipativeAssistant::ManagePoints.run(action, user, resource)
        end
      end
    end
  end
end

Decidim::ActionLogger.send(:include, Decidim::ParticipativeAssistant::ActionLoggerServiceExtend)


