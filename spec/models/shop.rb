# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shop, type: :model do
  let!(:shop) { FactoryBot.create :shop }
  let!(:publisher) { FactoryBot.create :publisher }
  let!(:book) { FactoryBot.create :book, publisher_id: publisher.id }
  let!(:shop_books) { FactoryBot.create :shop_book, book_id: book.id, shop_id: shop.id }

  describe 'Associations' do
    it { is_expected.to have_many(:shop_books) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end
end
