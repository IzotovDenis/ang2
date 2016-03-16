class CreatePcatalogs < ActiveRecord::Migration
  def change
    create_table :pcatalogs do |t|
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
