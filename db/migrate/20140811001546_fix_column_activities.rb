class FixColumnActivities < ActiveRecord::Migration
  def self.up
    rename_column :activities, :model, :controller
    add_column :activities, :action, :string
    add_column :activities, :ip, :string
  end
end
