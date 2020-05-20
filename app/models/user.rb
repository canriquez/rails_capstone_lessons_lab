class User < ApplicationRecord
  before_save :capitalize_name
  has_many :authored_courses, foreign_key: 'author_id', class_name: 'Group'
  has_many :enrolled_courses, foreign_key: 'student_id', class_name: 'Enroll'
  has_many :taught_sessions, foreign_key: 'teacher_id', class_name: 'Transaction'
  has_many :sitting_sessions, foreign_key: 'sitting_student_id', class_name: 'Transaction'
  has_many :my_courses, through: :enrolled_courses, source: :course

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[student teacher]

  validates :name, presence: true,
                   length: { maximum: 50 }

  validates :role, presence: true,
                   length: { maximum: 50 }

  def enrolled(course)
    enrolled_courses.where(course_id: course).count.positive?
  end

  def self.to_enroll(course)
    User.student.select('users.id as id, users.name as name').where.not(id: course.enrolled)
  end

  def self.enrolled_list(course)
    User.select('users.name as name, users.id as id')
      .where(id: Group.select('enrolls.student_id as id')
      .joins(:enrolled).where(id: course))
  end

  private

  def capitalize_name
    self.name = name.capitalize
  end
end
