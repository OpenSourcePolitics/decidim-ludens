# frozen_string_literal: true

module ActionLoggerServiceExtend
  extend ActiveSupport::Concern

  included do
    def self.log(action, user, resource, version_id, resource_extra = {})
      new(action, user, resource, version_id, resource_extra).log!
      Decidim::Ludens::ManagePoints.new(action, user, resource).run
    end
  end
end
