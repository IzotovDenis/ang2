class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :cid
      t.string :article
      t.string :title
      t.string :full_title
      t.string :group_cid
      t.integer :group_id
      t.string :image
      t.hstore :properties
      t.text :text

      t.timestamps
    end
  end
end
