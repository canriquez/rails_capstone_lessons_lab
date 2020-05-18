class Transaction < ApplicationRecord
  belongs_to :teacher, class_name: 'User'
  belongs_to :course_taught, class_name: 'Group', optional: true
  belongs_to :sitting_student, class_name: 'User', optional: true

  enum status: %i[generated accepted]

  scope :order_by_most_recent, -> { order(created_at: :desc) }
  scope :not_billable, -> { where(course_taught_id: [nil, '']) }

  def self.billable(current_user)
      Transaction.select("transactions.id, transactions.created_at as date,
      users.name as student_name, groups.name as course_name,
      transactions.minutes as minutes, groups.price as price,
      transactions.status as status, transactions.accdate as accepted_date")
      .joins(:sitting_student, :course_taught)
      .where(teacher_id: current_user).order_by_most_recent
  end
end
