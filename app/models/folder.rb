class Folder < ActiveRecord::Base
	has_ancestry
	has_many :ffiles

	after_save :set_children_cache
	after_destroy :set_children_cache

	def set_children_cache
		if self.parent
			self.parent.update_attribute("children_cache",self.parent.has_children?)
		end
	end
end
