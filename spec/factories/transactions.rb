FactoryBot.define do
  factory :transaction do
    teacher_id { 1 }
    enrolled_session { 1 }
    course_taught { 1 }
    status { 1 }
    minutes { 1 }
  end
end
