FactoryBot.define do
  factory :origin do
    name { Faker::Book.title }
    kind { Faker::Number.between(from: 0, to:3) }
    info { Faker::Lorem.sentence }
  end
end