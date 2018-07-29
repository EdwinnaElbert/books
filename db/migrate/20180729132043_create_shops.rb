class CreateShops < ActiveRecord::Migration[5.2]
  def up
    create_table :shops do |t|
      t.string :name, null: false
    end
  end

  def down
    drop_table :shops
  end
end
