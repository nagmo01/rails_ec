class CreatePurchasedItems < ActiveRecord::Migration[7.0]
  def change
    create_table :purchased_items do |t|
      t.references :payment, foreign_key: true
      t.string :name
      t.integer :price
      t.text :description
      t.integer :quantity

      t.timestamps
    end
  end
end
