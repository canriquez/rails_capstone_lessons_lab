FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@email.com"}
    password { "password" } 
    name  { "TestUser" }

    factory :student do
      enabled { :student }
    end

    factory :teacher do
      enabled { :teacher }
    end
  end
end
