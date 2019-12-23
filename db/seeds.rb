49.times do |n|
  name = Faker::Name.name
  description =  Faker::Lorem.sentence(word_count: 5)
  Author.create!(name: name, description: description)
end

6.times do |n|
  name = Faker::Name.name
  parent_id =  nil
  Category.create!(name: name, parent_id: parent_id)
end

10.times do |n|
  name = Faker::Name.name
  parent_id =  rand(10) + 1
  Category.create!(name: name, parent_id: parent_id)
end

20.times do |n|
  name = Faker::Name.name
  address = Faker::Address.city
  Publisher.create!(name: name, address: address)
end

49.times do |n|
  name = Faker::Name.name
  author_id = rand(49) + 1
  category_id = rand(10) + 1
  publisher_id = rand(20) + 1
  price = 200000
  amount = 200
  rest_amount = 20
  decription = Faker::Lorem.paragraph(sentence_count: 10, supplemental: false, random_sentences_to_add: 4)
  book = Book.create!(name: name, author_id: author_id, category_id: category_id, publisher_id: publisher_id,price: price,amount: amount, rest_amount: rest_amount,decription: decription )
  book.image.attach io: File.open(Rails.root
    .join("app", "assets", "images", "default_cover.jpg")),
    filename: "default_cover.jpg"
  book.save
end

User.create!(name: "Admin",
             sex: "female",
             birth: "12-11-1998",
             email: "admin@gmail.com",
             address: "Ha noi",
             phone: "0123456789",
             identity_card: "123456789",
             role: 1,
             password: "menmen",
             password_confirmation: "menmen",
             activated: true,
             activated_at: Time.zone.now)
20.times do |n|
  name  = Faker::Name.name
  email = "user#{n+1}@gmail.com"
  password = "123456"
  role = 2
  address = Faker::Address.city
  phone = Faker::PhoneNumber.cell_phone
  User.create!(name: name,
               sex: "female",
               birth: "12-11-1998",
               address: address,
               phone: phone,
               identity_card: rand(1234567890),
               role: 2,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
