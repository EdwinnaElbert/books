# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Publisher, type: :model do
  let!(:publisher) { FactoryBot.create :publisher }
  let!(:book) { FactoryBot.create :book, publisher_id: publisher.id }

  describe 'Associations' do
    it { is_expected.to have_many(:books) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:title) }
  end
end
