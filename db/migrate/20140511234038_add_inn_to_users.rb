class AddInnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :inn, :string
    add_index :users, :inn, unique: true
  end
end
