# frozen_string_literal: true

json.data do
  json.shops @shops do |s|
    json.id    s.id
    json.title s.name
    json.books_in_stock @shop.books do |b|
      json.id b.book.id
      json.id b.book.title
      json.id b.book.count
    end
  end
end
