# frozen_string_literal: true

class Publisher < ApplicationRecord
  has_many :books

  validates :title, presence: true
end
