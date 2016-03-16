class AddOgrnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ogrn, :string
  end
end
