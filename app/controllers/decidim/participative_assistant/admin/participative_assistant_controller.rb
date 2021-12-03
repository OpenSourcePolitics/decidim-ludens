module Decidim
  module ParticipativeAssistant
    module Admin
      class ParticipativeAssistantController < ParticipativeAssistant::Admin::ApplicationController
        def show;
          @recoEdition=ParticipativeAction.where(category:"Edition",completed:FALSE).limit(5)
          @recoEditionTotal=ParticipativeAction.where(category:"Edition",completed:FALSE)
          @recoEditionDone=ParticipativeAction.where(category:"Edition",completed:TRUE).limit(5)
          @recoEditionDoneTotal=ParticipativeAction.where(category:"Edition",completed:TRUE)
          @recoConfig=ParticipativeAction.where(category:"Configuration",completed:FALSE).limit(5)
          @recoConfigTotal=ParticipativeAction.where(category:"Configuration",completed:FALSE)
          @recoConfigDone=ParticipativeAction.where(category:"Configuration",completed:TRUE).limit(5)
          @recoConfigDoneTotal=ParticipativeAction.where(category:"Configuration",completed:TRUE)
          @recoCollab=ParticipativeAction.where(category:"Collaboration",completed:FALSE).limit(5)
          @recoCollabTotal=ParticipativeAction.where(category:"Collaboration",completed:FALSE)
          @recoCollabDone=ParticipativeAction.where(category:"Collaboration",completed:TRUE).limit(5)
          @recoCollabDoneTotal=ParticipativeAction.where(category:"Collaboration",completed:TRUE)
          @recoInteraction=ParticipativeAction.where(category:"Interaction",completed:FALSE).limit(5)
          @recoInteractionTotal=ParticipativeAction.where(category:"Interaction",completed:FALSE)
          @recoInteractionDone=ParticipativeAction.where(category:"Interaction",completed:TRUE).limit(5)
          @recoInteractionDoneTotal=ParticipativeAction.where(category:"Interaction",completed:TRUE)
        end
      end
    end
  end
end
