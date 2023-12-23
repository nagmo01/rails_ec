class DeleteSessionIdFromCarts < ActiveRecord::Migration[7.0]
  def up
    remove_column :carts, :session_id
  end

  def down
    add_column :carts, :session_id, :text
  end
end
