class AddDisabledToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :disabled, :boolean
  end
end
