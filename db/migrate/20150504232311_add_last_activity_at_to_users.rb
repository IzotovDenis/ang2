class AddLastActivityAtToUsers < ActiveRecord::Migration
def self.up
  add_column :users, :last_activity_at, :datetime

  User.reset_column_information
  User.find_each do |p|
  	if p.activities.last
		p.update_attribute("last_activity_at", p.activities.last.updated_at)
	end
  end
end

def self.down
  remove_column :users, :last_activity_at
end
end
