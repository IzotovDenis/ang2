class AddResultToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :result, :integer
  end
end
