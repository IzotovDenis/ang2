class ChangePriceFormatInPrice < ActiveRecord::Migration
  def change
  	change_column :prices, :value, :float
  end
end
