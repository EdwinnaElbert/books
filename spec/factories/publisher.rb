# frozen_string_literal: true

FactoryBot.define do
  factory :publisher do
    title { Faker::Company.name }
  end
end
