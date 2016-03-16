class AddStatusToPricelist < ActiveRecord::Migration
  def change
    add_column :pricelists, :status, :string
  end
end
