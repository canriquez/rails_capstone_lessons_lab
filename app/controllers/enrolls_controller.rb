class EnrollsController < ApplicationController


    def update
        @enroll = Enroll.new
        if @enroll.update_attributes(enrolls_params) # if we succeed to update
          redirect_to groups_path # then we show the update changes implemented
        else
          render :edit
        end
      end
    
      private
      def enrolls_params
        puts "Enrolled a new student, here are the params :"
        p params
        params.permit(:course_id, :student_id)
      end
end