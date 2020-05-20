class Transaction < ApplicationRecord
  belongs_to :teacher, class_name: 'User'
  belongs_to :course_taught, class_name: 'Group', optional: true
  belongs_to :sitting_student, class_name: 'User', optional: true

  enum status: %i[generated accepted]

  enum booking_type: %i[billable non-billable]

  scope :order_by_most_recent, -> { order(created_at: :desc) }
  scope :not_billable, -> { where(booking_type: 1) }

  validates :booking_type, presence: true
  validate :billable_course
  validate :billable_student
  validates :minutes, presence: true, numericality: true

  def self.billable(current_user)
    Transaction.select("transactions.id, transactions.created_at as date,
      users.name as student_name, groups.name as course_name,
      transactions.minutes as minutes, groups.price as price,
      transactions.status as status, transactions.accdate as accepted_date")
      .joins(:sitting_student, :course_taught)
      .where(teacher_id: current_user).order_by_most_recent
  end

  def self.student_billable(user)
    Transaction.select("transactions.id, transactions.created_at as date,
      users.name as student_name, groups.name as course_name, transactions.status as status,
      transactions.minutes as minutes, groups.price as price, transactions.accdate as accepted_date")
      .joins(:sitting_student, :course_taught)
      .where(sitting_student: user)
  end

  private

  def billable_course
    puts ' BOOKING TYPE: '
    p booking_type
    puts ' COURSE TAUGHT ID: '
    p course_taught_id

    return unless booking_type == 'billable'
    return unless course_taught_id.nil?

    errors.add(:course_taught_id, ': Please slect a course and student for billable bookings!')
  end

  def billable_student
    return unless booking_type == 'billable'
    return unless sitting_student_id.nil?

    errors.add(:sitting_student_id, ': Please slect a course and student for billable bookings!')
  end
end
