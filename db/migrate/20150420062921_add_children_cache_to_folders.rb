class AddChildrenCacheToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :children_cache, :boolean
  end
end
