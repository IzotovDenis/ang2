class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :cid
      t.string :title
      t.string :parent_cid
      t.string :ancestry

      t.timestamps
    end
  end
end
