# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    publisher
  end
end
