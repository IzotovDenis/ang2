class Slider < ActiveRecord::Base
	default_scope { order('position') }
end
