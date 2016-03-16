class AddIndexToCurrency < ActiveRecord::Migration
  def change
  	add_index :currencies, :name
  end
end
