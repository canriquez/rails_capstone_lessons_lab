require 'rails_helper'

describe GroupsController do
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
end 

