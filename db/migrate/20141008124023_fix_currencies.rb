class FixCurrencies < ActiveRecord::Migration
  def change
  	rename_column :currencies, :valuta, :name
  	remove_column :currencies, :value
  end
end
