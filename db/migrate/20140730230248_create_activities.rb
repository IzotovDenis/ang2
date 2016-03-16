class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.hstore :log
      t.string :model

      t.timestamps
    end
  end
end
