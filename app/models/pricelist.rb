class Pricelist < ActiveRecord::Base
	include PricelistHelper

	def self.current
		@pricelist = Pricelist.where(:status=>"success").last
	end

end
