FactoryBot.define do
  factory :transaction do
    teacher_id { 1 }

    factory :billable do
      sitting_student_id { 1 }
      course_taught_id { 1 }
      minutes { 15 }
      status { 0 }
    end

    factory :non_billable do
      minutes { 15 }
    end
  end
end
