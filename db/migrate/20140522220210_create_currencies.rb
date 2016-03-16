class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.float :value
      t.integer :user_id

      t.timestamps
    end
  end
end
