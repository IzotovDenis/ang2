class AddTotalToOrders < ActiveRecord::Migration

def self.up
  add_column :orders, :total, :float, :default => 0

  Order.reset_column_information
  Order.ready.all.each do |order|
  	order.update_attribute("total", order.amount)
  end
end

def self.down
  remove_column :orders, :total
end

end
