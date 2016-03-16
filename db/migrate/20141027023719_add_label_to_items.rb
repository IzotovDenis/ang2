class AddLabelToItems < ActiveRecord::Migration
  def change
    add_column :items, :label, :hstore
  end
end
