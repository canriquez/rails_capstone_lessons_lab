class EnrolledController < ApplicationController

    def enrolled
      @enrolled = User.select("users.name as name, users.id as id").
                  joins(:enrolled_courses).
                  where(id: Group.find(enrolled_params[:id]).enrollments).to_a
      #@enrolled = User.all
      p @enrolled

      respond_to do |format|
        format.json { render :json => @enrolled}
      end
    end 

    def to_enroll
      @to_enroll =  User.where.not(id: User.joins(:enrolled_courses).
      where(course_id: Group.find(enrolled_params[:id]).enrollments)))
      respond_to do |format|
        format.json { render :json => @enrolled}
      end
    end

    private
    def enrolled_params
      puts "Enroll, this are the params :"
      p params
      params.permit(:id)
    end
  end