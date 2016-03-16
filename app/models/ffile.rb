class Ffile < ActiveRecord::Base
	mount_uploader :file, FileUploader
	belongs_to :folder
end
