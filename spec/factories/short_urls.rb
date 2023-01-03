FactoryBot.define do
  factory :short_url do
    origin_url { Faker::Internet.url }
    hash_id { Faker::Number.number }
  end
end
