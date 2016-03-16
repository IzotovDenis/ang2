class RenameSlidersToBanners < ActiveRecord::Migration
  def change
    rename_table :sliders, :banners
  end 
end
