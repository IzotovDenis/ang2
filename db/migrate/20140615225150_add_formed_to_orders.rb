class AddFormedToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :formed, :datetime
  end
end
