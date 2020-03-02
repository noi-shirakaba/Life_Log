FactoryBot.define do
  factory :action do
    environment_id { 1 }
    sequence(:action_category) { |n| "TEST_ACTION_CATEGORY#{n}" }
  end
end
