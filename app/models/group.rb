class Group < ApplicationRecord

  belongs_to :author, class_name: 'User'
  has_many :enrollments, foreign_key: 'course_id', class_name: 'Enroll'
  has_many :booked_sessions, foreign_key: 'course_taught_id', class_name: 'Transactions'

  validates :name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: true
  validates :description, presence: true, length: { maximum: 200 }
  validates :duration, presence: true
  validates :price, presence: true,
                    length: { maximum: 50,
                              numericality: true }
  validates :starting, presence: true
  validates :cover_image, presence: true

  scope :enabled, -> { where(enabled: true) }
  scope :disabled, -> { where(enabled: false) }
  

end
