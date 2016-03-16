class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :item_id
      t.string :title
      t.integer :pricetype_id
      t.integer :value
      t.string :unit
      t.string :cy

      t.timestamps
    end
  end
end
