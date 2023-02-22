# frozen_string_literal: true

module Decidim
  module Ludens
    class ParticipativeAction < ApplicationRecord
      self.table_name = "decidim_participative_actions"

      belongs_to :organization,
                 foreign_key: "decidim_organization_id",
                 class_name: "Decidim::Organization"

      def translated_recommendation
        I18n.t("decidim.ludens.actions.#{recommendation}")
      end
    end
  end
end
