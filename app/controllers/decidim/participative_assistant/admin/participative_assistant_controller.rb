module Decidim
  module ParticipativeAssistant
    module Admin
      class ParticipativeAssistantController < ParticipativeAssistant::Admin::ApplicationController
        def show;
          @recoEdition=ParticipativeAction.where(category:"Edition",completed:FALSE)
          @recoEditionDone=ParticipativeAction.where(category:"Edition",completed:TRUE)
          @recoConfig=ParticipativeAction.where(category:"Configuration",completed:FALSE)
          @recoConfigDone=ParticipativeAction.where(category:"Configuration",completed:TRUE)
          @recoCollab=ParticipativeAction.where(category:"Collaboration",completed:FALSE)
          @recoCollabDone=ParticipativeAction.where(category:"Collaboration",completed:TRUE)
          @recoInteraction=ParticipativeAction.where(category:"Interaction",completed:FALSE)
          @recoInteractionDone=ParticipativeAction.where(category:"Interaction",completed:TRUE)
        end
      end
    end
  end
end
