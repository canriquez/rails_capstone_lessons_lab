class Enroll < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :course, class_name: 'Group'

  scope :enabled, -> { where(enabled: true) }

  def self.already_enrolled(student, course)
    Enroll.where(student_id: student).where(course_id: course).count
  end

end
