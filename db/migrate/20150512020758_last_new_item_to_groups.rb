class LastNewItemToGroups < ActiveRecord::Migration
  def change
  	add_column :groups, :last_new_item, :datetime
  end
end
