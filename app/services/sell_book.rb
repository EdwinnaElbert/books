class SellBook
  attr_accessor :book_id, :shop_id

  def initialize(book_id, shop_id, count)
    @shop_book = ShopBook.where(book_id: book_id, shop_id: shop_id).first
    @count = count
  end

  def sell
    if @count > @shop_book.count
      { json: "There are only #{@shop_book.count} books left in stock", status: 500 }
    elsif @shop_book
      @shop_book.update_attributes(sold_count: (@shop_book.sold_count += @count),
                                   count: (@shop_book.count -= @count))
      { json: @shop_book, status: 200 }
    else
      { json: 'No such book', status: 500 }
    end
  end
end
