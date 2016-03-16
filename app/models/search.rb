class Search < ActiveRecord::Base
	belongs_to :user

	default_scope { includes(:user).order('created_at desc') }

	def self.add_search(hash)
		Search.create!(hash)
	end
end
