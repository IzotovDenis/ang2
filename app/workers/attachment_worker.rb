class AttachmentWorker
  include Sidekiq::Worker

  def perform(file,dir)
	attach = Attachment.new
	attach.item_id = file['item_id']
	attach.comment = file['comment']
	attach.file = File.open("#{dir}/#{file['file']}")
	attach.save
  end
end