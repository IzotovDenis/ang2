class CreateCategoryDocs < ActiveRecord::Migration
  def change
    create_table :category_docs do |t|
      t.string :name
      t.string :ancestry

      t.timestamps
    end
  end
end
