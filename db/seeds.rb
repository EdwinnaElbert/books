# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    5.times  { Publisher.create(title: Faker::Company.name) }
    10.times { Shop.create(name: Faker::Company.name) }
    3.times  { Book.create(title: Faker::Book.title, publisher_id: Publisher.first.id) }
    ShopBook.create(book_id: Book.first.id, shop_id: Shop.first.id, sold_count: 5, count: 10)
    ShopBook.create(book_id: Book.last.id, shop_id: Shop.last.id, sold_count: 3, count: 2)
