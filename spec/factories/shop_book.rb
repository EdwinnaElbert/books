# frozen_string_literal: true

FactoryBot.define do
  factory :shop_book do
    shop
    book
    count 1
  end
end
