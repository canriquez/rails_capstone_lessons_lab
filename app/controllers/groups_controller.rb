class GroupsController < ApplicationController
  
  def index
    @group = Group.enabled.last
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_course_params)
    if @group.save
      redirect_to groups_path, notice: 'Course has been created'
      #I redirect to the index of courses by design instead of tipically redirect to the new created course
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_course_params)  #if we succeed to update
      redirect_to group_path(@group)  #then we show the update changes implemented 
    else 
      render :edit
    end

  end

  def destroy
    Group.destroy(params[:id])
    redirect_to groups_path
  end


  private

  def group_course_params
    params.require(:group).permit(:name, :description, :duration,
                                  :price, :online, :presencial, :classroom,
                                  :cover_image, :starting)
  end
end
