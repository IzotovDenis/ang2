class ImageRecreateVersionWorker
  include Sidekiq::Worker

	def perform(item_id)
		item = Item.find(item_id)
		if item.image
			item.image.recreate_versions!(:thumb, :thumb_m)
		end
	end
end

