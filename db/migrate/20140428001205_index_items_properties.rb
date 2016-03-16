class IndexItemsProperties < ActiveRecord::Migration
  def up
  	execute "CREATE INDEX items_properties ON items USING GIN(properties)"
  end

  def down
  	execute "DROP INDEX items_properties"
  end
end
