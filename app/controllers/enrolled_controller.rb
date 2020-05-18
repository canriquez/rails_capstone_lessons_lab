class EnrolledController < ApplicationController

  #used to populate the 'select student' selector in transactions#new view
  def enrolled
    @enrolled = User.enrolled_list(enrolled_params[:id])
    p @enrolled
    respond_to do |format|
      format.json { render json: @enrolled }
    end
  end

  #used to populate the 'student to enroll' selector in group index view.
  def enrolar
    @to_enroll = User.to_enroll(Group.find(enrolled_params[:id]))

    puts ('AVAILABLE STUDENTS TO ENROLL: ')
    p @to_enroll
    respond_to do |format|
      format.json { render json: @to_enroll }
    end
  end

  private

  def enrolled_params
    puts 'Enroll, this are the params :'
    p params
    params.permit(:id)
  end
end
