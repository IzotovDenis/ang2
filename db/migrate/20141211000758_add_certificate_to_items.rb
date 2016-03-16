class AddCertificateToItems < ActiveRecord::Migration
  def change
    add_column :items, :certificate, :string
  end
end
