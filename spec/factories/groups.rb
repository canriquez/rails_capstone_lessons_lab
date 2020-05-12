FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "course #{n}" }
    description { 'yes this is a course description' }
    duration { 30 }
    price { '9.99' }
    starting { '22/2/22' }
    cover_image { 'my file' }
    online { true }
    presencial { true }
    enabled { true }
    author { 1 }

    factory :group_enabled do
      enabled { true }
    end

    factory :group_disabled do
      enabled { false }
    end
  end
end
