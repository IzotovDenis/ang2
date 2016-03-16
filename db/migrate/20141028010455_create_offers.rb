class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :variant
      t.hstore :store
      t.string :status

      t.timestamps
    end
  end
end
