class Currency < ActiveRecord::Base
	belongs_to :user
	has_many :rates
	belongs_to :price, foreign_key: "cy"


	def rate
		if @rate = rates.last
			@rate.value
		else
			0
		end
	end
	
end
