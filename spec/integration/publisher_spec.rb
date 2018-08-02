# frozen_string_literal: true

require 'swagger_helper'

describe 'Books on Sale for Publisher' do
  let!(:publisher)    { FactoryBot.create :publisher }
  let!(:publisher_1)  { FactoryBot.create :publisher }

  let!(:book)         { FactoryBot.create :book, publisher: publisher }
  let!(:book_1)       { FactoryBot.create :book, publisher: publisher }
  let!(:book_2)       { FactoryBot.create :book, publisher: publisher }
  let!(:book_3)       { FactoryBot.create :book, publisher: publisher_1 }


  let!(:shop)         { FactoryBot.create :shop }
  let!(:shop_1)       { FactoryBot.create :shop }
  let!(:shop_book)    { FactoryBot.create :shop_book, book: book, shop: shop, count: 2, sold_count: 1 }
  let!(:shop_book_4)  { FactoryBot.create :shop_book, book: book_1, shop: shop_1, count: 2, sold_count: 1 }
  # let!(:shop_book_1)  { FactoryBot.create :shop_book, book: book_1, shop: shop_1, count: 5, sold_count: 0 }
  let!(:shop_book_2)  { FactoryBot.create :shop_book, book: book_2, shop: shop, count: 3, sold_count: 2 }
  let!(:shop_book_3)  { FactoryBot.create :shop_book, book: book_3, shop: shop, count: 3, sold_count: 10 }

  path '/publishers/{publisher_id}/shops' do
    get 'Get shops' do
      tags 'Shops'
      security [bearerAuth: {}]
      consumes 'application/json'
      # parameter title: :shop_id, in: :path, type: :string
      # parameter title: :id, in: :path, type: :string
      # Green
      response '200', 'Get shops' do
        schema type: :object,
          required:  [:data],
          properties: {
            data: {
              type: :object,
              required: [:publisher],
              properties: {
                publisher: {
                  type: :object,
                  required: [:id],
                  properties: {
                    shops: [{
                      id:   { type: :integer },
                      name: { type: :string },
                      books_sold_count: { type: :integer },
                      books_in_stock: [
                        id:    { type: :integer },
                        title: { type: :string },
                        copies_in_stock: { type: :integer }
                      ]
                    }]
                  }
                }
              }
            }
          }
        it '.shops' do
          headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
          get "/publishers/#{publisher.id}/shops", headers: headers
          expect(response).to have_http_status(200)
          # expect(JSON.parse(response.body)['data']['stock']['id']).to eq(stock.id)
          # expect(JSON.parse(response.body)['data']['stock']['title']).to eq(stock.title)
          # expect(JSON.parse(response.body)['data']['stock']['shop_id']).to eq(shop.id)
          puts JSON.parse(response.body)
        end
      end
    end
  end
end
