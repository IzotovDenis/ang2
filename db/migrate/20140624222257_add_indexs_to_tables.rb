class AddIndexsToTables < ActiveRecord::Migration
  def change
  	add_index :items, :group_id
  	add_index :order_items, :item_id
  	add_index :order_items, :order_id
  	add_index :orders, :user_id
  	add_index :prices, :item_id
  end
end
