class AddSiteTitleToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :site_title, :string
  end
end
