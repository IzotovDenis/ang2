class AddActivityCountToUsers < ActiveRecord::Migration
def self.up
  add_column :users, :activities_count, :integer, :default => 0

  User.reset_column_information
  User.all.each do |p|
    User.update_counters p.id, :activities_count => p.activities.length
  end
end

def self.down
  remove_column :users, :activities_count
end
end