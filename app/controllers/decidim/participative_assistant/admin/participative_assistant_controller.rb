module Decidim
  module ParticipativeAssistant
    module Admin
      class ParticipativeAssistantController < ParticipativeAssistant::Admin::ApplicationController
        def show;
          @recoEdition=ParticipativeAction.where(category:"Edition",completed:FALSE)
          @recoConfig=ParticipativeAction.where(category:"Configuration",completed:FALSE)
          @recoCollab=ParticipativeAction.where(category:"Collaboration",completed:FALSE)
          @recoInteraction=ParticipativeAction.where(category:"Interaction",completed:FALSE)
        end
      end
    end
  end
end
