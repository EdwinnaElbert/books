class CreateShopBooks < ActiveRecord::Migration[5.2]
  def up
    create_table :shop_books do |t|
      t.integer :count, null: false, default: 1
      t.integer :shop_id
      t.integer :book_id
    end

    add_foreign_key :shop_books, :shops
    add_foreign_key :shop_books, :books
  end

  def down
    drop_table :shop_books
  end
end
