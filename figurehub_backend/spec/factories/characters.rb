FactoryBot.define do
  factory :character do
    name { Faker::FunnyName.name }
    gender { Faker::Number.between(from: 0, to: 2) }
    info { Faker::Lorem.sentence }
    origin_id { nil }
  end
end