class Transaction < ApplicationRecord
    belongs_to :teacher, class_name: "User"
    #belongs_to :course_taught, class_name: "Group"
    #belongs_to :enrolled_session, class_name: "Enroll"

    enum status: [ :generated, :accepted ]
end
