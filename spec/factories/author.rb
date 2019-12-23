FactoryBot.define do
  factory :author do
    name {Faker::Name.name}
    description {Faker::Lorem.sentence(word_count: Settings.word_amount)}
  end
end
