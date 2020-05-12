FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@email.com"}
    password { "password" } 
    name  { "TestUser" }

    factory :student_user do
      role { :student }
    end

    factory :teacher_user do
      role { :teacher }
    end
  end
end
