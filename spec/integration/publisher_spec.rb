# frozen_string_literal: true

require 'swagger_helper'

describe 'Books on Sale for Publisher' do
  let!(:publisher)    { FactoryBot.create :publisher }


  let!(:book)         { FactoryBot.create :book, publisher: publisher }
  let!(:book_1)       { FactoryBot.create :book, publisher: publisher }
  let!(:book_2)       { FactoryBot.create :book, publisher: publisher }

  let!(:shop)         { FactoryBot.create :shop }
  let!(:shop_1)       { FactoryBot.create :shop }

  let!(:shop_book_4)  { FactoryBot.create :shop_book, book: book_1, shop: shop_1, count: 2, sold_count: 1 }

  let!(:shop_book)    { FactoryBot.create :shop_book, book: book, shop: shop, count: 2, sold_count: 1 }
  let!(:shop_book_2)  { FactoryBot.create :shop_book, book: book_2, shop: shop, count: 3, sold_count: 2 }

  let!(:publisher_1)  { FactoryBot.create :publisher }
  let!(:book_3)       { FactoryBot.create :book, publisher: publisher_1 }
  let!(:shop_book_3)  { FactoryBot.create :shop_book, book: book_3, shop: shop, count: 3, sold_count: 10 }


  path '/publishers/{publisher_id}/shops' do
    get 'Get shops' do
      tags 'Shops'
      security [bearerAuth: {}]
      consumes 'application/json'
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
          result = JSON.parse(JSON.parse(response.body)['shops'])
          # check ordered_by
          expect(result[0]['id']).to eq(shop.id)
          expect(result[1]['id']).to eq(shop_1.id)

          # check book presence
          expect(result[0]['books_in_stock'][0]['book_id']).to eq(book.id)
          expect(result[0]['books_in_stock'][1]['book_id']).to eq(book_2.id)

          expect(result[1]['books_in_stock'][0]['book_id']).to eq(book_1.id)

          # check sold_count
          expect(result[0]['books_sold_count']).to eq(3)
          expect(result[1]['books_sold_count']).to eq(1)
        end
      end

      response 'status 404', 'Publisher not found' do
        schema type: :object,
               required: [:errors],
               properties: {
                 errors: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       code: { type: :integer }
                     }
                   }

                 }
               }
        it 'has 404 status code if publisher not found' do
          headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
          get "/publishers/#{SecureRandom.uuid}/shops", headers: headers
          expect(response).to have_http_status(404)
        end
      end
    end
  end
end
