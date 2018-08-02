# frozen_string_literal: true

# shops

class PublishersController < ApplicationController
  # respond_to :json
  before_action :set_publisher, only: [:shops]

  def show; end

  def shops
    # binding.pry
    hashh = Shop.all.joins(shop_books: :book).where("books.publisher_id = ?", @publisher.id).reduce([]) do |acc, shop|
      acc << {
        id: shop.id,
        name: shop.name,
        # books_sold_count: shop.shop_books.sold_count,
        books_in_stock: shop.shop_books.map { |shop_book|
          { id: shop_book.book_id,
            title: shop_book.book.title,
            copies_in_stock: shop_book.count,
            publisher_id: shop_book.book.publisher_id
          }
        }
      }
    end
    binding.pry
    render status: 200
  end

  protected

  def set_publisher
    @publisher = Publisher.find_by_id(params[:id])
    return render status: 404, json: { errors: [{ code: 404, title: 'Publisher not found' }] } unless @publisher # Вынести errors?
  end
end
