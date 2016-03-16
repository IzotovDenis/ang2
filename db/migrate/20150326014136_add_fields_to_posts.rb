class AddFieldsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :title, :string
    add_column :posts, :position, :integer
    add_column :posts, :published, :boolean, :default => false
    add_column :posts, :block, :string
  end
end
