# frozen_string_literal: true

class ShopBook < ApplicationRecord
  belongs_to :shop
  belongs_to :book

  validates :count, :sold_count, :shop_id, :book_id, presence: true
end
