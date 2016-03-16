class Price < ActiveRecord::Base
	belongs_to :item
	has_one :currency, :primary_key => :cy, :foreign_key => :name
	has_one :rates, through: :currency
end
