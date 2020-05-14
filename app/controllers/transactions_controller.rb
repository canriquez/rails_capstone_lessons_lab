class TransactionsController < ApplicationController
    def index

      if current_user.role == 'teacher'
        @transactions = Transaction.select("transactions.id, transactions.created_at as date, 
                                          users.name as student_name, groups.name as course_name, 
                                          transactions.minutes as minutes, groups.price as price, 
                                          transactions.status as status, transactions.accdate as accepted_date").
        joins(:sitting_student, :course_taught).
        where(teacher_id: current_user)
      else 
        @transactions = Transaction.select("transactions.*, users.*,groups.*").
        joins(:sitting_student, :course_taught).
        where(sitting_student_id: current_user)
      end

        p @transactions

    end

    def new
        @transaction = Transaction.new
    end

    def create
        @transaction = Transaction.new(transaction_params)
        @transaction.teacher_id = current_user.id 
        @transaction.status = :generated
        if @transaction.save
          redirect_to groups_path, notice: "Booking has been created"
          # I redirect to the index of bookings by design instead of tipically redirect to the new created course
        else
          render :new
        end

    end

    private

  def transaction_params
    params.require(:transaction).permit(:course_taught_id, :sitting_student_id, :minutes )
  end

    
end