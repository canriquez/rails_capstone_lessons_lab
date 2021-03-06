class GroupsController < ApplicationController
  # before_action :authenticate_user!, only: %i[index show new create edit update destroy]
  before_action :authors_only, only: %i[edit update destroy confirm_destroy]
  before_action :authors_or_enrolled_only, only: [:show]
  before_action :teachers_only, only: %i[new create]

  def index
    @group = if current_user.teacher?
               current_user.authored_courses.distinct(:course_id)
             else
               current_user.my_courses.distinct(:course_id)
             end
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_course_params)
    @group.author_id = current_user.id # It is required only in testing.
    if @group.save
      redirect_to groups_path, notice: "Course #{@group.name} has been created"
      # I redirect to the index of courses by design instead of tipically redirect to the new created course
    else
      render :new
    end
  end

  def edit; end

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
    redirect_to groups_path, notice: "Course #{@course.name} was  eliminated."
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
                                  :cover_image, :starting, :enabled, :author_id)
  end

  def authors_only
    @group = Group.find(params[:id])
    @course = @group
    redirect_to groups_path if current_user != @group.author
  end

  def authors_or_enrolled_only
    @group = Group.find(params[:id])
    return if current_user == @group.author || Enroll.already_enrolled(current_user, @group)

    redirect_to groups_path, notice: 'you are not authorised for this action'
  end

  def teachers_only
    return if current_user.teacher?

    puts 'WARNING TEACHERS ONLY FAILED'
    redirect_to groups_path, notice: 'you are not authorised for this action'
  end
end
