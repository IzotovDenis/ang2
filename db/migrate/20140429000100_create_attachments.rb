class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file
      t.string :comment
      t.integer :item_id

      t.timestamps
    end
  end
end
