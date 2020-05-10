FactoryBot.define do
  factory :group do
    name { "MyString" }
    description { "MyText" }
    duration { 1 }
    price { "9.99" }
    online { "MyString" }
    presencial { "MyString" }
    classroom { false }
    cover_image { "MyString" }
  end
end
