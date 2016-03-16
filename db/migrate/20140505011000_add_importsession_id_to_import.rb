class AddImportsessionIdToImport < ActiveRecord::Migration
  def change
    add_column :imports, :importsession_id, :integer
  end
end
