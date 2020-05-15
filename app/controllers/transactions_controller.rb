class TransactionsController < ApplicationController
  before_action :authors_only, only: %i[destroy confirm_destroy]

  def index
    if current_user.role == 'teacher'
      @transactions = Transaction.select("transactions.id, transactions.created_at as date,
                                          users.name as student_name, groups.name as course_name,
                                          transactions.minutes as minutes, groups.price as price,
                                          transactions.status as status, transactions.accdate as accepted_date")
        .joins(:sitting_student, :course_taught)
        .where(teacher_id: current_user).order_by_most_recent
      @tran_not_billable = Transaction.not_billable.order_by_most_recent
      p @tran_not_billable
    else
      @transactions = Transaction.select("transactions.id, transactions.created_at as date,
          users.name as student_name, groups.name as course_name,
          transactions.minutes as minutes, groups.price as price,
          transactions.status as status, transactions.accdate as accepted_date")
        .joins(:sitting_student, :course_taught)
        .where(sitting_student_id: current_user)
    end
  end

  def show
    @transaction = Transaction.find(transaction_params[:id])
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.teacher_id = current_user.id
    @transaction.status = :generated
    if @transaction.save
      redirect_to transactions_path, notice: 'Booking has been created'
      # I redirect to the index of bookings by design instead of tipically redirect to the new created course
    else
      render :new
    end
  end

  def destroy
    puts 'WE GET TO DESTROY'
    @transaction.destroy
    redirect_to transactions_path, notice: 'Course transaction was  eliminated.'
  end

  def confirm_destroy
    p @transaction
    respond_to do |format|
      format.js
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:course_taught_id, :sitting_student_id, :minutes)
  end

  def authors_only
    @transaction = Transaction.find(params[:id])
    puts "Current user role: #{current_user.role},
    is authorised to destroy? : #{current_user == @transaction.teacher_id}"
    puts "Current user id: #{@transaction.teacher_id},
    current_user.id :#{current_user.id}"
    return if current_user.id == @transaction.teacher_id

    puts "Current user role: #{current_user.role},
    is authorised to destroy? : #{current_user == @transaction.teacher_id}"
    puts "Current user id: #{@transaction.teacher_id},
    current_user.id :#{current_user.id}"
    redirect_to transactions_path, notice: 'you are not authorised for this action'
  end
end
