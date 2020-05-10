class GroupsController < ApplicationController
  def index; end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_course_params)
    if @group.save
      redirect_to groups_path, notice: 'Course has been created'
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  private

  def group_course_params
    params.require(:group).permit(:name, :description, :duration,
                                  :price, :online, :presencial, :classroom,
                                  :cover_image, :starting)
  end
end
