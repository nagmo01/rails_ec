class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.text :sha, null: false
      t.references :item, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
