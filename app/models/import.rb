class Import < ActiveRecord::Base
		mount_uploader :filename, ImportUploader
		belongs_to :importsession 
end
