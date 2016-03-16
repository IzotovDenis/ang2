class CreateImportsessions < ActiveRecord::Migration
  def change
    create_table :importsessions do |t|
      t.string :cookie
      t.string :status

      t.timestamps
    end
  end
end
