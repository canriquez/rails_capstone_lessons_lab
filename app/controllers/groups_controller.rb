class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]
  before_action :authors_only, only: [ :edit, :update, :destroy, :confirm_destroy ]
  before_action :authors_or_enrolled_only, only: [ :show ]


  def index
    @group = Group.all
    @student_courses = Group.student_courses(current_user)

  end

  def show
    @group = Group.find(params[:id])
  end


  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_course_params)
    if @group.save
      redirect_to groups_path, notice: "Course #{@group.name} has been created"
      # I redirect to the index of courses by design instead of tipically redirect to the new created course
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update_attributes(group_course_params) # if we succeed to update
      redirect_to groups_path # then we show the update changes implemented
    else
      render :edit
    end
  end

  def destroy
    puts 'WE GET TO DESTROY'
    @course.destroy
    redirect_to groups_path, notice: "Course #{@course.name } was  eliminated."
  end

  def confirm_destroy
    p @course
    respond_to do |format|
      format.js
    end
  end

  private

  def group_course_params
    params.require(:group).permit(:name, :description, :duration,
                                  :price, :online, :presencial, :classroom,
                                  :cover_image, :starting, :enabled)
  end

  def authors_only
    @group = Group.find(params[:id])
    @course = @group
    if current_user != @group.author 
      redirect_to groups_path
    end
  end

  def authors_or_enrolled_only
    @group = Group.find(params[:id])
    return if current_user == @group.author || current_user.enrolled(@group)
    
    redirect_to groups_paths
  end
end
