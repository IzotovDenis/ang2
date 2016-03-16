class AddCidIndexInItems < ActiveRecord::Migration
  def change
  	add_index :items, :cid
  end
end
