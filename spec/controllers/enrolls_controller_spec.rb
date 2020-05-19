require 'rails_helper'

# rubocop:disable Metrics/BlockLength,Layout/LineLength,Lint/UselessAssignment,Naming/VariableNumber

describe EnrollsController do

  describe 'Teacher User' do

    context 'logged in and course owner' do
      describe 'POST enrolls (create)' do
        #one teacher, one student, one course. Test: one enrollment.
        let(:t1) { FactoryBot.create(:teacher_user) }
        before do
          sign_in(t1)
        end
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
    end

    context 'logged in not course owner' do

      describe 'POST enrolls create' do
        #one teacher, one student, one course. Test: one enrollment.
        let(:t1) { FactoryBot.create(:teacher_user) }
        let(:t2) { FactoryBot.create(:teacher_user) }

        before do
          sign_in(t2)
        end
        let(:s1) { FactoryBot.create(:student_user) }
        let(:c1) { FactoryBot.create(:group_enabled, author: t1) }

        it 'fails to enroll and redirect to course index page' do
          expect do
            post :create, params: { student: s1, course: c1 }
            expect(response).to redirect_to(groups_path)
          end
        end

        it 'creates the enroll and updates de DB' do
          expect do
            post :create, params: { student: s1, course: c1 }
          end.to change(Enroll, :count).by(0)
        end
      end

      describe 'DELETE request to destroy a course enrollment'
    end

  end

  describe 'Student User' do
    context 'logged in not course owner' do

      describe 'POST enrolls create' do
        #one teacher, one student, one course. Test: one enrollment.
        let(:t1) { FactoryBot.create(:teacher_user) }
        let(:s1) { FactoryBot.create(:student_user) }

        before do
          sign_in(s1)
        end
      
        let(:c1) { FactoryBot.create(:group_enabled, author: t1) }

        it 'fails to enroll and redirect to course index page' do
          expect do
            post :create, params: { student: s1, course: c1 }
            expect(response).to redirect_to(groups_path)
          end
        end

        it 'creates the enroll and updates de DB' do
          expect do
            post :create, params: { student: s1, course: c1 }
          end.to change(Enroll, :count).by(0)
        end
      end

    end
  end
end

# rubocop:enable Metrics/BlockLength,Layout/LineLength,Lint/UselessAssignment,Naming/VariableNumber
