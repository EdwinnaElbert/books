# frozen_string_literal: true

# shops

class ShopsController < ApplicationController
  respond_to :json

  def update
    render status: http_status(@shop)
  end

  protected

    def shop_params
      params.require(:shop).permit(:name,
                                   shop_books_attributes: [
                                      :book_id,
                                      :count
                                   ])
    end

end
