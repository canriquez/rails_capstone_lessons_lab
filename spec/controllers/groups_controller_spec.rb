require 'rails_helper'


describe GroupsController do

  describe "Student User " do
    #we create student, course and login as student
    let(:teacher_1) { FactoryBot.create(:teacher_user) }
    let(:student_1) { FactoryBot.create(:student_user) }
    let(:other_student) { FactoryBot.create(:student_user) }

    let(:other_student_enrolled_course_1) {FactoryBot.create(:enroll, student: student_1, course: course_1)}
    before do
      sign_in(student_1)
    end

    describe 'GET course index list where student is enrolled' do
      it 'renders :index template' do      
        get :index
        expect(response).to render_template(:index)
      end
      it "selects only 'enrolled' courses for the student to show on index" do
        course_1 = FactoryBot.create(:group_enabled, author: teacher_1)
        FactoryBot.create(:enroll, student: student_1, course: course_1)

        get :index
        expect(assigns(:student_courses)).to match_array([course_1])
      end
    end

    describe 'GET show course' do

      it 'renders :show template only if user is enrolled in the course' do
        course_1 = FactoryBot.create(:group_enabled, author: teacher_1)
        FactoryBot.create(:enroll, student: student_1, course: course_1)
        get :show, params: { id: course_1 }
        expect(response).to render_template(:show)
      end
      it 'assigns requested course to the @student_course variable for the loged_in student' do
        course_1 = FactoryBot.create(:group_enabled, author: teacher_1)
        FactoryBot.create(:enroll, student: student_1, course: course_1)
        get :show, params: { id: course_1 }
        expect(assigns(:group)).to eq(course_1)
        #:group is the variable defined in the groups_controller.rb file for eny course.
      end
    end

    #A student cannot create a new course
    describe "GET new course" do
      it "fails to render the new course form and redirects to login page" do
        get :new
        expect(response).to redirect_to(groups_path)
      end
    end

    describe 'POST course create' do
      let(:course_1) { FactoryBot.create(:group_enabled, author: teacher_1) }  
        it 'fails and redirects to login page instead as student cannot create courses' do
          post :create, params: { group: course_1}
          expect(response).to redirect_to(groups_path)
        end
    end

    describe 'GET course for edit' do
      let(:course_1) { FactoryBot.create(:group_enabled, author: teacher_1) }   
      it 'fails to render :edit template as students are not allowed to edit courses' do
        get :edit, params: { id: course_1 }
        expect(response).to redirect_to(groups_path)
      end
    end

    describe 'PUT request to update course' do
      let(:course_1) { FactoryBot.create(:group_enabled, author: teacher_1) }   
      let(:valid_course_data_change) { FactoryBot.attributes_for(:group_enabled, name: 'Course name update') }
      it 'fails to PUT a change on the course record' do
        put :update, params: { id: course_1, group: valid_course_data_change }
        expect(response).to redirect_to(groups_path)
      end
    end

    describe 'DELETE request to destroy a course record' do
      let(:course_1) { FactoryBot.create(:group_enabled, author: teacher_1) }   
      it 'fails to destroy a course record' do
        delete :destroy, params: { id: course_1 }
        expect(response).to redirect_to(groups_path)
      end
    end

  end

  describe "Teacher User" do
    let(:teacher_1) { FactoryBot.create(:teacher_user) }
    let(:teacher_2) { FactoryBot.create(:teacher_user) }

    before do
      sign_in(teacher_1)
    end

    describe 'GET course index' do
      it 'renders :index template' do
        get :index
        expect(response).to render_template(:index)
      end
      it "selects only coursed where teacher is the author" do
        course_1 = FactoryBot.create(:group_enabled, name: 'teacher 1 course', author: teacher_1)
        course_2 = FactoryBot.create(:group_enabled, name: 'teacher 2 course', author: teacher_2)
        get :index
        expect(assigns(:group)).to match_array([course_1])
      end
    end

    describe 'GET show course' do
      it 'renders :show template and is able to edit authored courses' do
        course_1 = FactoryBot.create(:group_enabled, name: 'teacher 1 course', author: teacher_1)
        get :show, params: { id: course_1 }
        expect(response).to render_template(:show)
      end
      it 'assigns the authored course to the @group instance variable (for edition)' do
        course_1 = FactoryBot.create(:group_enabled, name: 'teacher 1 course', author: teacher_1)
        get :show, params: { id: course_1 }
        expect(assigns(:group)).to eq(course_1)
        #:group is the variable defined in the groups_controller.rb file
      end
    end

    describe 'GET new for teacher' do
      it 'renders :new template to create a new course' do
        get :new
        expect(response).to render_template(:new)
      end
      it 'assigns new Group to @group instance variable' do
        get :new
        expect(assigns(:group)).to be_a_new(Group)
      end
    end
  
    describe 'POST create' do
      let(:valid_course_data) { FactoryBot.attributes_for(:group, name: 'teacher-1 course', author: teacher_1.id) }
      let(:invalid_course_data) { FactoryBot.attributes_for(:group, name: nil, author: teacher_1.id) }
  
      context 'with valid data' do
        it 'redirects to show the course index in  goups#index' do
          post :create, params: { group: valid_course_data }
          expect(response).to redirect_to(groups_path)
        end
        it 'creates a new group/course in the database' do
          expect do
            post :create, params: { group: valid_course_data }
          end.to change(Group, :count).by(1)
        end
      end
      
      context 'with invalid data' do
        it 'redirects to :new and shows :error notice' do
          post :create, params: { group: invalid_course_data }
          expect(response).to render_template(:new)
          # expect(response).to have_content("can't be blank")
        end
        it 'does not create a new :group in the database' do
          expect do
            post :create, params: { group: invalid_course_data }
          end.not_to change(Group, :count)
        end
      end
    end

    context "and teacher is not the owner of the course" do

      describe 'GET course edit' do
        let(:valid_group_course) { FactoryBot.create(:group, author: another_teacher_user) }
        it 'fails to render :edit template redirects to course index' do
          get :edit, params: { id: valid_group_course }
          expect(response).to redirect_to(groups_path)
        end
      end
  
      describe 'PUT request to update course' do
        let(:valid_group_course) { FactoryBot.create(:group, author: another_teacher_user) }
        let(:valid_course_data_change) { FactoryBot.attributes_for(:group_enabled, name: 'Course name update') }
        it 'fails to PUT a change on the course record redirects to course index' do
          put :update, params: { id: valid_group_course, group: valid_course_data_change }
          expect(response).to redirect_to(groups_path)
        end
      end
  
      describe 'DELETE request to destroy a course record' do
        let(:valid_group_course) { FactoryBot.create(:group, author: another_teacher_user) }
        it 'fails to destroy a course record redirects to course index' do
          delete :destroy, params: { id: valid_group_course }
          expect(response).to redirect_to(groups_path)
        end
      end
      
    end
    
    context "teacher is the owner of the course" do
      let(:enabled_group_course) { FactoryBot.create(:group_enabled, author: teacher_user) }
      describe 'GET edit' do    
        it 'renders :edit template' do
          get :edit, params: { id: enabled_group_course }
          expect(response).to render_template(:edit)
        end
        it 'assigns the requested group/course to the view' do
          get :edit, params: { id: enabled_group_course }
          expect(assigns(:group)).to eq(enabled_group_course)
        end
      end
    
      describe 'PUT update action with ' do
        # we first create the grou/course we will test by updating with valid and invalid data.  
        context 'valid data for enabled group/course' do
          let(:valid_course_data_change) { FactoryBot.attributes_for(:group_enabled, name: 'Course name update') }
    
          it 'redirects to groups#show action' do
            put :update, params: { id: enabled_group_course, group: valid_course_data_change }
            expect(response).to_not redirect_to(enabled_group_course)
          end
          it 'updates group/course changes in the database' do
            put :update, params: { id: enabled_group_course, group: valid_course_data_change }
            enabled_group_course.reload # I reload DB record to fetch new object changes
            expect(enabled_group_course.name).to eq('Course name update') # I check directly in the DB (integration test)
          end
        end
    
        context 'invalid data with enabled group/course' do
          let(:invalid_course_data_change) { FactoryBot.attributes_for(:group, name: nil) }
    
          it 'renders :edit view template' do
            put :update, params: { id: enabled_group_course, group: invalid_course_data_change }
            expect(response).to render_template(:edit)
          end
          it 'fails to update the group/course changes in the DB' do
            put :update, params: { id: enabled_group_course, group: invalid_course_data_change }
            enabled_group_course.reload # I reload DB record to fetch new object changes
            expect(enabled_group_course.name).not_to eq('Course name update')
            # I check directly in the DB (integration test)
          end
        end
      end
    
      describe 'DELETE action to destroy' do
        # we first create the grou/course we will test by destroying.
        it 'not to redirect to groups/courses index as AJAX is in use' do
          delete :destroy, params: { id: enabled_group_course }
          expect(response).to redirect_to(groups_path)
        end
        it 'deletes group/course from database' do
          delete :destroy, params: { id: enabled_group_course }
          expect(Group.exists?(enabled_group_course.id)).to be_falsy
        end
      end
    end

  end


end
