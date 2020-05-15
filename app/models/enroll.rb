class Enroll < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :course, class_name: 'Group'
  # has_many   :sessions, foreign_key: "enrolled_session_id", class_name: "Transaction"
end
