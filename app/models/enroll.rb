class Enroll < ApplicationRecord
    belongs_to :student, class_name: "User"
    belongs_to :course, class_name: "Group"
end
