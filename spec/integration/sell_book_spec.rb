# frozen_string_literal: true

require 'swagger_helper'

describe 'Sale Books for Shop' do
  let!(:publisher)    { FactoryBot.create :publisher }

  let!(:book)         { FactoryBot.create :book, publisher: publisher }
  let!(:shop)         { FactoryBot.create :shop }
  let!(:shop_book)    { FactoryBot.create :shop_book, book: book, shop: shop, count: 10, sold_count: 1 }

  valid = Faker::Number.between(1, 10)
  too_many = Faker::Number.between(100, 200)
  let!(:valid_params) do
    {
      book: {
        id: book.id,
        count: valid
      }
    }
  end

  let!(:more) do
    {
      book: {
        id: book.id,
        count: too_many
      }
    }
  end

  let!(:no_such_book) do
    {
      book: {
        id: SecureRandom.uuid,
        count: Faker::Number.between(11, 20)
      }
    }
  end

  path '/shops/{shop_id}/sell_books' do
    put 'Update a shop' do
      tags 'Shops'
      security [bearerAuth: {}]
      consumes 'application/json'
      parameter name: :body, in: :body, schema: {
        type: :object,
        required: [:book],
        properties: {
          book: {
            required: [:id, :count],
            properties: {
              id: { type: :integer },
              count: { type: :integer }
            }
          }
        }
      }

      response '200', 'Books sold' do
        schema type: :object,
          required: [:data],
          properties: {
            data: {
              type: :object,
              required: [:book],
              properties: {
                shop: {
                  type: :object,
                  required: [:id, :count],
                  properties: {
                    id: { type: :integer },
                    count: { type: :integer }
                  }
                }
              }
            }
          }
        it 'sell book with valid params' do
          headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
          put "/shops/#{shop.id}/sell_books", headers: headers, params: valid_params.to_json
          expect(response).to have_http_status(200)
          expect(JSON.parse(response.body)['count']).to eq(shop_book.count - valid)
        end
      end

      response '404', 'shop not found' do
        schema type: :object,
          required: [:data],
          properties: {
            data: {
              type: :object,
              required: [:book],
              properties: {
                shop: {
                  type: :object,
                  required: [:id, :count],
                  properties: {
                    id: { type: :integer },
                    count: { type: :integer }
                  }
                }
              }
            }
          }
        it 'shop not found' do
          headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
          put "/shops/#{SecureRandom.uuid}/sell_books", headers: headers, params: valid_params.to_json
          expect(response).to have_http_status(404)
          expect(JSON.parse(response.body)['errors'][0]['title']).to eq('Shop not found')
        end
      end

      response '404', 'Book not found' do
        schema type: :object,
          required: [:data],
          properties: {
            data: {
              type: :object,
              required: [:book],
              properties: {
                shop: {
                  type: :object,
                  required: [:id, :count],
                  properties: {
                    id: { type: :integer },
                    count: { type: :integer }
                  }
                }
              }
            }
          }
        it 'shop not found' do
          headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
          put "/shops/#{shop.id}/sell_books", headers: headers, params: no_such_book.to_json
          expect(response).to have_http_status(404)
          expect(JSON.parse(response.body)['errors'][0]['title']).to eq('Book not found')
        end
      end

      response '404', 'Too many books requested' do
        schema type: :object,
          required: [:data],
          properties: {
            data: {
              type: :object,
              required: [:book],
              properties: {
                shop: {
                  type: :object,
                  required: [:id, :count],
                  properties: {
                    id: { type: :integer },
                    count: { type: :integer }
                  }
                }
              }
            }
          }
        it 'Too many books requested' do
          headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
          put "/shops/#{shop.id}/sell_books", headers: headers, params: more.to_json
          expect(response).to have_http_status(500)
          expect(JSON.parse(response.body)['errors'][0]['title']).to eq("There are only #{shop_book.count} books left in stock")
        end
      end
    end
  end
end
