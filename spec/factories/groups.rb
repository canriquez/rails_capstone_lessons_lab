FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "course #{n}" }
    description { "yes this is a course description" }
    duration { 30 }
    price { "9.99" }
    online { true }
    presencial { true }
    classroom { false }
    starting {"22/2/22"}
    cover_image { "my file" }
  end
end
