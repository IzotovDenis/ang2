class Attachment < ActiveRecord::Base
	belongs_to :item
	mount_uploader :file, AttachmentUploader
end
