require 'rails_helper'

# rubocop:disable Metrics/BlockLength,Layout/LineLength,Lint/UselessAssignment,Naming/VariableNumber

describe EnrollsController do

  describe 'Teacher User' do
    #one teacher, one student, one course. Test: one enrollment.
    let(:t1) { FactoryBot.create(:teacher_user) }
    before do
      sign_in(t1)
    end

    context 'when teacher is the owner of the course' do

      describe 'POST enrolls create' do
        let(:s1) { FactoryBot.create(:student_user) }
        let(:c1) { FactoryBot.create(:group_enabled, author: t1) }

        it 'creates the enroll and redirect to success controller' do
          expect do
            post :create, params: { student: s1, course: c1 }
            expect(response).to redirect_to(notices_path)
          end
        end

        it 'creates the enroll and updates de DB' do
          expect do
            post :create, params: { student_id: s1, course_id: c1 }
          end.to change(Enroll, :count).by(1)
        end
      end

      describe 'DELETE request to destroy a course enrollment'
    end
  end
end

# rubocop:enable Metrics/BlockLength,Layout/LineLength,Lint/UselessAssignment,Naming/VariableNumber
