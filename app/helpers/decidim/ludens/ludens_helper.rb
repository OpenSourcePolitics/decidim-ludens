# frozen_string_literal: true

module Decidim
  module Ludens
    module LudensHelper
      def last_completed
        @last_completed ||= Decidim::Ludens::ParticipativeActionCompleted.last
      end

      def actions_instance
        Decidim::Ludens::ParticipativeActions.instance
      end
    end
  end
end
