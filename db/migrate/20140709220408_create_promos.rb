class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.string :name
      t.string :file
      t.integer :position

      t.timestamps
    end
  end
end
