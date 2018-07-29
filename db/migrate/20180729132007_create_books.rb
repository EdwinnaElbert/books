class CreateBooks < ActiveRecord::Migration[5.2]
  def up
    create_table :books do |t|
      t.string :title, null: false
      t.integer :publisher_id, null: false
    end

    add_foreign_key :books, :publishers
  end

  def down
    drop_table :books
  end
end
