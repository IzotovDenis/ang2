class AddActualToCurrency < ActiveRecord::Migration
  def change
    add_column :currencies, :actual, :float
  end
end
