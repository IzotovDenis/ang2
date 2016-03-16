class CreatePricelists < ActiveRecord::Migration
  def change
    create_table :pricelists do |t|
      t.integer :size

      t.timestamps
    end
  end
end
