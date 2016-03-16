class Offer < ActiveRecord::Base
	attr_accessor :name


	def items
		Item.where("label -> :variant = :value",:variant=>variant, :value=>id.to_s)
	end

	def items_array
		items.pluck(:id).join(",")
	end

	def text
		if store && store['text']
			store['text']
		else
			nil
		end 
	end

	def thumb
		if store && store['thumb']
			store['thumb']
		else
			nil
		end 
	end

end
