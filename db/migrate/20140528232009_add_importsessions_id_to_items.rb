class AddImportsessionsIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :importsession_id, :integer
  end
end
