class AddOrderItemsToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :order_list, :jsonb, :default => {}

	Order.find_each do |order|
		hash = {}
		OrderItem.where(:order_id => order.id).includes(:item).each do |order_item|
			hash[order_item.item.id] = {}
			hash[order_item.item.id]['qty'] = order_item.qty
			hash[order_item.item.id]['price'] = order_item.price if order_item.price != 0.0
		end
		order.update_attribute("order_list", hash)
	end
  end

	def self.down
	  remove_column :orders, :order_list
	end

end
