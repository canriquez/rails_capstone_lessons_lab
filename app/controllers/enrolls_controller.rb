class EnrollsController < ApplicationController

  def create
    puts 'Enroll params into create: '
    p enrolls_params
    @enroll = Enroll.new(enrolls_params)
    if @enroll.save # if we succeed to update
      puts 'We created successfully '
      p @enroll
      redirect_to enroll_path(@enroll), notice: 'New student enrolled' # then we show the update changes implemented
    else
      puts 'failed to create'
      p @enrolls.to_a
      p @enroll.errors.full_messages
      redirect_to groups_path
    end
  end

  def show
  end



  private

  def enrolls_params
    puts 'Enrolled a new student, here are the params :'
    p params
    params.permit(:course_id, :student_id)
  end
end
