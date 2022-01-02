# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    nickname { Faker::Name.name }
    kind { Faker::Number.between(from: 0, to:2) }
    avatar { nil }
    password { 'pass' }
  end
end