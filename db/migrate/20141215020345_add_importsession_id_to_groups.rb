class AddImportsessionIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :importsession_id, :integer
  end
end
