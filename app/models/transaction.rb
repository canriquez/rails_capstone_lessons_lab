class Transaction < ApplicationRecord
    belongs_to :teacher, class_name: "User"
    belongs_to :course_taught, class_name: "Group", optional: true
    belongs_to :sitting_student, class_name: "User", optional: true

    enum status: [ :generated, :accepted ]

    scope :order_by_most_recent, -> { order(created_at: :desc) }
    scope :not_billable, -> { where(course_taught_id: [nil, ""])}

end
