# frozen_string_literal: true

json.data do
  json.shop do
    json.id @shop.id
    json.title @shop.title
    json.shop_currencies @shop.shop_books do |b|
      json.id b.id
    end
  end
end
