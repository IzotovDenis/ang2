class AddBidsToItems < ActiveRecord::Migration
  def change
    add_column :items, :bids, :jsonb, null: false, default: '{}'
  end
end
