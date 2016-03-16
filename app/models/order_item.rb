class OrderItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :item
	has_many :prices, :through => :item
	belongs_to :user

	before_save :check_qty
	scope :able, -> {includes(:item=>:group).order("groups.position, items.position")}

	def set_price
		self.price = item.price.to_f
		self.save
	end

	def amount
		self.qty * self.item.price
	end

	def check_qty
		if self.qty == nil || self.qty == 0 || self.qty < 1
			self.qty = 1
		end
	end
end