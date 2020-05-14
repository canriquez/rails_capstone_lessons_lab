class TransactionsController < ApplicationController
    def index
        if current_user.role == 'teacher'
        @transaction = Transaction.find_by_sql("SELECT s.*, users.name
            FROM (SELECT transactions.id as transaction_id, enrolls.student_id as student_id, groups.name as course_name,  transactions.minutes, transactions.status,   groups.price, transactions.created_at
            FROM transactions
            JOIN enrolls
            ON transactions.enrolled_session_id = enrolls.id
            JOIN groups
            ON transactions.course_taught_id = groups.id
            WHERE transactions.teacher_id = ? ) as s
            JOIN users
            ON users.id = s.student_id ORDER BY created_at DESC", current_user)
        p @transaction
        end
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
    params.require(:transaction).permit(:course_taught_id, :enrolled_session_id, :minutes )
  end

    
end