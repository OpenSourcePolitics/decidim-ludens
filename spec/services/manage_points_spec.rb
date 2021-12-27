#frozen_string_literal: true

require 'spec_helper'

module Decidim
  module ParticipativeAssistant
    describe ManagePoints do
      subject { described_class }

      let(:organization) { create :organization }
      let(:user) { create :user, organization: organization, current_sign_in_ip: '127.0.0.1' }
      let(:participatory_space) { create :participatory_process, organization: organization }
      let(:component) { create :component, participatory_space: participatory_space }
      let(:resource) { create :dummy_resource, component: component }
      let(:action) { 'create' }
      let(:subject_run) { subject.run(action, user, resource) }

      describe '.run' do
        context 'when participative action is not present' do
          let!(:participative_action) { nil }

          it 'returns nil' do
            expect(subject_run).to eq(nil)
          end
        end

        context 'when participative action is present' do
          before do
            ParticipativeAction.find_or_create_by!(action: action,
                                                  resource: resource.class.to_s,
                                                  completed: false,
                                                  recommendation: 'My recommendation',
                                                  points: 1
            )
          end

          it 'updates organization' do
            subject_run
            expect(organization.assistant).to eq(JSON.parse(JSON.generate({
                                                                            score: 1,
                                                                            flash: "Congratulations ! You just completed the action \'My recommendation\' !",
                                                                            last: ParticipativeAction.find_by(action: action, resource: resource.class.to_s).id
                                                                          })))
          end

          it 'updates participative_action' do
            subject_run
            expect(ParticipativeAction.find_by(action: action, resource: resource.class.to_s).completed).to be_truthy
          end
        end
      end
    end
  end
end


