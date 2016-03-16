class Banner < ActiveRecord::Base
	default_scope { order('position') }

	before_create :set_position

	after_destroy :update_all_positions

	def set_position
		if banner = Banner.where(:location=>self.location).last
			self.position = banner.position + 1
		else
			self.position = 1
		end
	end

	def update_all_positions
		banners = Banner.where(:location=>self.location)
		banners.each_with_index do |banner, index|
			banner.update_attribute(:position, index + 1)
		end
	end
end
