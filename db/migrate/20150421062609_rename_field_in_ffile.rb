class RenameFieldInFfile < ActiveRecord::Migration
  def change
  	rename_column :ffiles, :category_doc_id, :folder_id
  end
end
