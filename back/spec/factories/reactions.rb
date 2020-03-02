FactoryBot.define do
  factory :reaction do
    environment_id { 1 }
    sequence(:content) { |n| "TEST_REACTION_CONTENT#{n}" }
    # content { "MyString" }
  end
end
