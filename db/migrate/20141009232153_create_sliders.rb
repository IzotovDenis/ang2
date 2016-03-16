class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.string :image
      t.hstore :action
      t.integer :position

      t.timestamps
    end
  end
end
