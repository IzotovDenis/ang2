class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :currency_id
      t.float :value
      t.integer :user_id

      t.timestamps
    end
  end
end
