# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShopBook, type: :model do
  let!(:shop) { FactoryBot.create :shop }
  let!(:publisher) { FactoryBot.create :publisher }
  let!(:book) { FactoryBot.create :book, publisher_id: publisher.id }

  describe 'Associations' do
    it { is_expected.to belong_to(:shop) }
    it { is_expected.to belong_to(:book) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:count) }
    it { should validate_presence_of(:shop_id) }
    it { should validate_presence_of(:book_id) }
  end

end
