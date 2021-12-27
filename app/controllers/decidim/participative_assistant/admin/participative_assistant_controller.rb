module Decidim
  module ParticipativeAssistant
    module Admin
      class ParticipativeAssistantController < ParticipativeAssistant::Admin::ApplicationController
        helper_method :list_of_participative_actions

        def show
          @recoEdition = ParticipativeAction.where(category: "Edition", completed: false).limit(5)
          @recoEditionTotal = ParticipativeAction.where(category: "Edition", completed: false)
          @recoEditionDone = ParticipativeAction.where(category: "Edition", completed: true).limit(5)
          @recoEditionDoneTotal = ParticipativeAction.where(category: "Edition", completed: true)
          @recoConfig = ParticipativeAction.where(category: "Configuration", completed: false).limit(5)
          @recoConfigTotal = ParticipativeAction.where(category: "Configuration", completed: false)
          @recoConfigDone = ParticipativeAction.where(category: "Configuration", completed: true).limit(5)
          @recoConfigDoneTotal = ParticipativeAction.where(category: "Configuration", completed: true)
          @recoCollab = ParticipativeAction.where(category: "Collaboration", completed: false).limit(5)
          @recoCollabTotal = ParticipativeAction.where(category: "Collaboration", completed: false)
          @recoCollabDone = ParticipativeAction.where(category: "Collaboration", completed: true).limit(5)
          @recoCollabDoneTotal = ParticipativeAction.where(category: "Collaboration", completed: true)
          @recoInteraction = ParticipativeAction.where(category: "Interaction", completed: false).limit(5)
          @recoInteractionTotal = ParticipativeAction.where(category: "Interaction", completed: false)
          @recoInteractionDone = ParticipativeAction.where(category: "Interaction", completed: true).limit(5)
          @recoInteractionDoneTotal = ParticipativeAction.where(category: "Interaction", completed: true)
        end

        def list_of_participative_actions
          participative_actions.group_by(&:category)
                               .each_with_object({}) do |actions, hash|
            hash[actions[0]] = {
              completed: actions[1].select(&completed?),
              uncompleted: actions[1].reject(&completed?)
            }
          end
        end
      end

      private

      def participative_actions
        @participative_actions ||= ParticipativeAction.all
      end
    end
  end
end
