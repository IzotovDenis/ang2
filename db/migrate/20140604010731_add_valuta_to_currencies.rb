class AddValutaToCurrencies < ActiveRecord::Migration
  def change
    add_column :currencies, :valuta, :string
  end
end
