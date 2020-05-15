class EnrolledController < ApplicationController
  def enrolled
    @enrolled = User.select('users.name as name, users.id as id')
      .joins(:enrolled_courses)
      .where(id: Group.find(enrolled_params[:id]).enrollments).to_a
    p @enrolled

    respond_to do |format|
      format.json { render json: @enrolled }
    end
  end

  def enrolar
    @to_enroll = User.select('users.id, users.name')
      .where.not(id: Enroll.select('student_id as id')
    .joins(:student).where(course: Group.find(enrolled_params[:id]).enrollments)).to_a

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
