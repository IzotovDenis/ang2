class Promo < ActiveRecord::Base
	mount_uploader :file, PromofileUploader
	default_scope { order('position') }
	belongs_to :pcatalog
end
