class RenameDocTables < ActiveRecord::Migration
  def change
    rename_table :docs, :ffiles
    rename_table :category_docs, :folders
  end 
end
