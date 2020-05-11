require 'rails_helper'

describe GroupsController do

    describe "GET course index" do
        let(:group_course_enabled) { FactoryBot.create(:group_enabled) }
        #let(:group_course_disabled) { FactoryBot.create(:group_disabled) }
        it "renders :index template" do
            get :index
            expect(response).to render_template(:index)
        end
        it "selects only 'enabled' courses in the index - any delivery info flag is true -" do
            get :index
            expect(assigns(:group)).to match_array([group_course_enabled])

        end
    end

    describe "GET edit" do
        let(:enabled_group_course) { FactoryBot.create(:group_enabled) }
        it "renders :edit template" do
            get :edit, params: { id: enabled_group_course }
            expect(response).to render_template(:edit)
        end
        it "assigns the requested group/course to the view" do
            get :edit, params: { id: enabled_group_course }
            expect(assigns(:group)).to eq(enabled_group_course)
        end
    end

    describe "PUT update action with " do
        let(:enabled_group_course) { FactoryBot.create(:group_enabled) }
        #we first create the grou/course we will test by updating with valid and invalid data.

        context "valid data for enabled group/course" do
            let(:valid_course_data_change) { FactoryBot.attributes_for(:group_enabled, name: "Course name update") }
           
            it "redirects to groups#show action" do
                put :update, params: { id: enabled_group_course, group: valid_course_data_change }
                expect(response).to redirect_to(enabled_group_course)
            end
            it "updates group/course changes in the database" do
                put :update, params: { id: enabled_group_course, group: valid_course_data_change }
                enabled_group_course.reload  #I reload DB record to fetch new object changes
                expect(enabled_group_course.name).to eq("Course name update") #I check directly in the DB (integration test)
            end
        end

        context "invalid data with enabled group/course" do
            let(:invalid_course_data_change) { FactoryBot.attributes_for(:group, name: nil)}

            it "renders :edit view template" do
                put :update, params: { id: enabled_group_course, group: invalid_course_data_change }
                expect(response).to render_template(:edit)
            end
            it "fails to update the group/course changes in the DB" do
                put :update, params: { id: enabled_group_course, group: invalid_course_data_change }
                enabled_group_course.reload  #I reload DB record to fetch new object changes
                expect(enabled_group_course.name).not_to eq("Course name update") #I check directly in the DB (integration test)
            end
        end
    end 

    describe "GET new" do
        it "renders :new template" do
            get :new
            expect(response).to render_template(:new)
        end
        it "assigns new Group to @group instance variable" do
            get :new
            expect(assigns(:group)).to be_a_new(Group)
        end
    end

    describe "GET show" do
        let(:group_course) { FactoryBot.create(:group) }
        it "renders :show template" do
            get :show, params: { id: group_course }
            expect(response).to render_template(:show)
        end
        it "assigns requested Group to the @group instance variable" do
            get :show, params: { id: group_course }
            expect(assigns(:group)).to eq(group_course)
            #:group is the variable defined in the groups_controller.rb file
        end
    end

    describe "POST create" do
        let(:valid_course_data) { FactoryBot.attributes_for(:group) }
        let(:invalid_course_data) { FactoryBot.attributes_for(:group, name: nil)}

        context "with valid data" do

            it "redirects to show the course index in  goups#index" do
                post :create, params: { group: valid_course_data }
                expect(response).to redirect_to(groups_path)
            end
            it "creates a new group/course in the database" do
                expect {
                    post :create, params: { group: valid_course_data }
                }.to change(Group, :count).by(1)
            end
        end
        context "with invalid data" do

            it "redirects to :new and shows :error notice" do
                post :create, params: { group: invalid_course_data }
                expect(response).to render_template(:new)
                #expect(response).to have_content("can't be blank")
            end
            it "does not create a new :group in the database" do
                expect {
                    post :create, params: { group: invalid_course_data }
                }.not_to change(Group, :count)
            end
        end
    end

    describe "DELETE action to destroy" do
        let(:enabled_group_course) { FactoryBot.create(:group_enabled) }
        #we first create the grou/course we will test by destroying.

        it "redirects to groups/courses index" do
            delete :destroy, params: { id: enabled_group_course }
            expect(response).to redirect_to(groups_path)
        end
        it "deletes group/course from database" do
            delete :destroy, params: { id: enabled_group_course }
            expect(Group.exists?(enabled_group_course.id)).to be_falsy
        end
        
    end

end 

