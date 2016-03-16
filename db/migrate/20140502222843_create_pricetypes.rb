class CreatePricetypes < ActiveRecord::Migration
  def change
    create_table :pricetypes do |t|
      t.string :cid
      t.string :title
      t.string :cy

      t.timestamps
    end
  end
end
