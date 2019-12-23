FactoryBot.define do
  factory :publisher do
    name {Faker::Name.name}
    address {Faker::Address.city}
  end
end
