# frozen-string_literal: true

module Decidim
  module ParticipativeAssistant
    class ParticipativeActionCompletedEvent < Decidim::Events::SimpleEvent

      def resource_path
        @resource.url
      end

      def resource_url
        attached_to_url
      end

      def resource_text
        translated_attribute(
          resource.try(:description) ||
            resource.try(:body)
        )
      end

      private

      def attached_to_url
        resource_locator.url
      end

      def resource
        @resource.attached_to
      end
    end
  end
end
