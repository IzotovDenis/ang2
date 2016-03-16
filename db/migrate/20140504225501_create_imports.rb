class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.string :filename
      t.string :status

      t.timestamps
    end
  end
end
