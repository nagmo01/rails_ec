class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :last_name
      t.string :first_name
      t.string :user_name
      t.string :email
      t.string :address
      t.string :address2
      t.string :country
      t.string :state
      t.integer :zip
      t.string :cc_name
      t.integer :cc_number
      t.integer :cc_expiration
      t.integer :cc_cvv

      t.timestamps
    end
  end
end
