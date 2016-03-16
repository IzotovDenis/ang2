class Pcatalog < ActiveRecord::Base
	has_many :promos
	default_scope { order('position') }
end
