class AddPcatalogIdToPromos < ActiveRecord::Migration
  def change
    add_column :promos, :pcatalog_id, :integer
  end
end
