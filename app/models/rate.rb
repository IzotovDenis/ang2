class Rate < ActiveRecord::Base
	belongs_to :currency

	after_create :set_actual_currency

	def set_actual_currency
		self.currency.update_attribute(:actual, self.value)
	end

end
