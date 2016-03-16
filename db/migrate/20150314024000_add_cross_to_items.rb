class AddCrossToItems < ActiveRecord::Migration
  def change
    add_column :items, :cross, :string, array: true
    add_index :items, :cross
  end
end
