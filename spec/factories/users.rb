FactoryBot.define do
  factory :user do

    sequence(:email) { |n| "email#{n}@email.com" }
    password { 'password' }
    sequence(:name) { |n| "#{n}-User" }

    factory :student_user do
      role { :student }
    end

    factory :teacher_user do
      role { :teacher }
    end
  end
end
