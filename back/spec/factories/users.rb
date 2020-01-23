FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
    trait :with_environments do
      after(:create) { |user| create_list(:environment, 10, user: user) }
    end
  end
end
