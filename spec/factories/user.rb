FactoryBot.define do
  factory :user do
    name {Faker::Name.unique.name}
    email {"user@gmail.com"}
    password {"123456"}
    role {2}
    address {Faker::Address.city}
    phone {Faker::PhoneNumber.cell_phone}
    sex {"female"}
    birth {"12-11-1998"}
    identity_card {1234567890}
    activated {true}
    activated_at {Time.zone.now}
  end
end
