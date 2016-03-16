class AddDefaultValueQtyToItems < ActiveRecord::Migration
  def change
  	change_column :items, :qty, :integer, :default => 0
  end
end
