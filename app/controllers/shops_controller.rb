# frozen_string_literal: true

class ShopsController < ApplicationController
  before_action :set_shop, only: [:sell_books]

  def sell_books
    return render status: 404, json: { errors: [{ code: 404, title: 'Book not found' }] } if set_book.nil?

    render SellBook.new(@book.id, @shop.id, book_params[:count]).sell
  end

  protected

  def shop_params
    params.require(:shop).permit(:name, shop_books_attributes: [:book_id, :count, :sold_count])
  end

  def book_params
    params.require(:book).permit(:id, :count)
  end

  def set_shop
    @shop = Shop.find_by_id(params[:id])
    return render status: 404, json: { errors: [{ code: 404, title: 'Shop not found' }] } unless @shop
  end

  def set_book
    @book = @shop.books.find_by_id(book_params[:id])
  end
end
