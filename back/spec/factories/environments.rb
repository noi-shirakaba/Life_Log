FactoryBot.define do
  factory :environment do
    sequence(:situation) { |n| "TEST_SITUATION#{n}" }
  end
end
