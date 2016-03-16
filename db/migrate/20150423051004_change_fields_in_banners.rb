class ChangeFieldsInBanners < ActiveRecord::Migration
  def change
  	remove_column :banners, :action, :hstore
  	add_column :banners, :location, :string
  	add_column :banners, :label, :string
  	add_column :banners, :link, :string
  end
end
