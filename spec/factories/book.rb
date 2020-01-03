FactoryBot.define do
  factory :book do
    name {Faker::Name.name}
    price {Settings.price}
    amount {Settings.amount}
    rest_amount {Settings.rest_amount}
    decription {Faker::Lorem.paragraph(sentence_count: Settings.sentence_count, supplemental: false, random_sentences_to_add: Settings.random_sentences_to_add)}
    after(:build) do |book|
      book.image.attach(io: File.open(Rails.root.join("app", "assets", "images", "default_cover.jpg")), filename: "default_cover.jpg")
    end
    association :author
    association :category
    association :publisher
  end
end
