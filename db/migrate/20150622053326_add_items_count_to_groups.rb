class AddItemsCountToGroups < ActiveRecord::Migration
def self.up
  add_column :groups, :items_count, :integer, :default => 0

  Group.reset_column_information
  Group.find_each do |group|
    group.update_attribute('items_count', group.items.count)
  end
end

def self.down
  remove_column :groups, :items_count
end

end
