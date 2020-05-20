class EnrollsController < ApplicationController
  before_action :authenticate_user!
  before_action :rejects_duplications, only: [:create]

  def create
    p enrolls_params
    @enroll = Enroll.new(enrolls_params)

    if @enroll.save # if we succeed to create
      puts 'Enroll params into create: '
      puts "current_user id is : #{current_user.id}"
      puts "course_author is : #{Group.find(@enroll.course_id).author.id}"
      puts 'We created successfully '
      p @enroll
      redirect_to enroll_path(@enroll)
    else
      puts 'failed to create'
      p @enrolls.to_a
      p @enroll.errors.full_messages
      redirect_to groups_path
    end
  end

  def show
    @enroll = Enroll.find(params[:id])
  end

  private

  def enrolls_params
    puts 'Enrolled a new student, here are the params :'
    p params
    params.permit(:course_id, :student_id)
  end

  def rejects_duplications
    return if Enroll.already_enrolled(params[:student_id], params[:course_id]).zero?

    redirect_to groups_path, notice: 'there was an error with the enrollment, please try again'
  end
end
