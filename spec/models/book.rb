# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  let!(:publisher) { FactoryBot.create :publisher }
  let!(:book) { FactoryBot.create :book, publisher_id: publisher.id }

  # red
  describe 'Associations' do
    it { is_expected.to belong_to(:publisher) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:title) }
  end
end
