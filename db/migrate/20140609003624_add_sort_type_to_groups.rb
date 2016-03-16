class AddSortTypeToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :sort_type, :string, :default => "auto"
  end
end
