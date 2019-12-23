FactoryBot.define do
  factory :user do
    name  { Faker::Name.name }
    sex { "female" }
    birth { "12-11-1998" }
    identity_card { "1234567890" }
    email { "user#{rand(100)}@gmail.com" }
    password_digest {BCrypt::Password.create("123456")}
    role { Settings.enum_user }
    address { Faker::Address.city }
    phone { Faker::PhoneNumber.cell_phone }
    activated { true }
    activated_at { Time.zone.now }
  end
end
