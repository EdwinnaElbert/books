# frozen_string_literal: true

class Shop < ApplicationRecord
  has_many :shop_books
  has_many :books, through: :shop_books
end
