class AddBrandToPromos < ActiveRecord::Migration
  def change
    add_column :promos, :brand, :string
  end
end
