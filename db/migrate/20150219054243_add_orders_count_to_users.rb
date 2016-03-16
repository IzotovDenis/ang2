class AddOrdersCountToUsers < ActiveRecord::Migration
def self.up
  add_column :users, :orders_count, :integer, :default => 0

  User.reset_column_information
  User.all.each do |p|
    User.update_counters p.id, :orders_count => p.orders.ready.length
  end
end

def self.down
  remove_column :users, :orders_count
end
end
