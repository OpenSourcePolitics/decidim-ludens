# frozen_string_literal: true

module Decidim
  module Ludens
    class SetupService
      def self.retrieve_actions
        raise "Please run migration first to initialize Ludens" unless Decidim::Ludens::ParticipativeActionCompleted.table_exists?

        Decidim::Organization.all.find_each do |organization|
          Decidim::ActionLog.where(organization: organization).find_each do |log|
            puts "Action added : #{log.action} - #{log.resource.class}" if Decidim::Ludens::ManagePoints.new(log.action, log.user, log.resource).run
          end
        end
      end

      def self.remove_unregistered_actions
        raise "Please run migration first to initialize Ludens" unless Decidim::Ludens::ParticipativeActionCompleted.table_exists?

        Decidim::Ludens::ParticipativeActionCompleted.all.find_each do |action|
          puts "Action removed : #{action.decidim_participative_action}" unless action.participative_action
          action.destroy unless action.participative_action
        end
      end
    end
  end
end
