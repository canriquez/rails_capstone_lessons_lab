class Enroll < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :course, class_name: 'Group'

  validates :student_id, presence: true
  validates :course_id, presence: true


  def self.already_enrolled(student, course)
    Enroll.where(student_id: student).where(course_id: course).count
  end

end
