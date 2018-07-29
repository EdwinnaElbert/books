class CreatePublishers < ActiveRecord::Migration[5.2]
  def up
    create_table :publishers do |t|
      t.string :title, null: false
    end
  end

  def down
    drop_table :publishers
  end
end
