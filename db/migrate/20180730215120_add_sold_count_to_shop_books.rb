class AddSoldCountToShopBooks < ActiveRecord::Migration[5.2]
  def up
    add_column :shop_books, :sold_count, :integer, null: false, default: 0
  end

  def down
    add_column :shop_books
  end
end
