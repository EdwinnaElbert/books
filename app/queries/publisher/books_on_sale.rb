class BooksOnSale
  attr_accessor :publisher

  def initialize(publisher)
    @publisher = publisher
  end

  def on_sale
    shops_sql = "WITH shop_publisher_books AS (
                   SELECT s.id,
                          s.name,
                          b.id as book_id,
                          COALESCE(sb.count, 0) AS copies_in_stock,
                          COALESCE(sb.sold_count, 0) AS sold_copies_count,
                          b.title
                   FROM shops AS s
                     INNER JOIN shop_books sb ON sb.shop_id = s.id
                     INNER JOIN books b ON b.id = sb.book_id
                     INNER JOIN publishers p ON b.publisher_id = p.id
                   WHERE p.id = $1
                   GROUP BY s.id, s.name, b.id, b.title, sb.count, sb.sold_count
                   ORDER BY s.id DESC ),

                   selected_shops AS (
                     SELECT DISTINCT ON (id)
                       id,
                       name
                     FROM shop_publisher_books
                     GROUP BY shop_publisher_books.id, shop_publisher_books.name
                     )

            SELECT array_to_json(array_agg(row_to_json(t)))
                from (
                  SELECT id,
                         name,
                         (SELECT sum(sold_copies_count) OVER () FROM shop_publisher_books WHERE id = selected_shops.id LIMIT 1) AS books_sold_count,
                         (select array_to_json(array_agg(row_to_json(d))) FROM (
                             SELECT book_id,
                                    title,
                                    copies_in_stock
                             FROM shop_publisher_books
                             WHERE id = selected_shops.id
                           ) d ) AS books_in_stock
                    FROM selected_shops
                    ORDER BY books_sold_count DESC
                 ) t "

    @shops = ActiveRecord::Base.connection.select_all(shops_sql, 'SQL', [[nil, @publisher.id]])[0]
    @shops['shops'] = @shops.delete 'array_to_json'
    @shops
  end
end
