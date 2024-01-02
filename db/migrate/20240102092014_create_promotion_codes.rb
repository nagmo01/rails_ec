class CreatePromotionCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :promotion_codes do |t|
      t.references :payment, foreign_key: true
      t.string :code
      t.integer :discount_amount

      t.timestamps
    end
  end
end
