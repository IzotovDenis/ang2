class AddPriceToOrderItems < ActiveRecord::Migration

	def self.up
	  add_column :order_items, :price, :float, :default => 0

	  OrderItem.reset_column_information
	  OrderItem.includes(:order, :prices).find_each do |order_item|
	  	if order_item.order != nil && order_item.order.formed?
	  		order_item.update_attribute("price", order_item.item.price)
	  	end
	  end
	end

	def self.down
	  remove_column :order_items, :price
	end

end
