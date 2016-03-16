class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.string :file
      t.string :name
      t.integer :category_doc_id

      t.timestamps
    end
  end
end
