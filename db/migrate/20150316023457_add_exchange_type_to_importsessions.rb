class AddExchangeTypeToImportsessions < ActiveRecord::Migration
  def change
    add_column :importsessions, :exchange_type, :string
  end
end
