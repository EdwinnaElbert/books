# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :publisher

  has_many :shop_books
  has_many :shops, through: :shop_books

  validates :title, presence: true
end
