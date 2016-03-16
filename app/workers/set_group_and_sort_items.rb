class SetGroupAndSortItems
  include Sidekiq::Worker
  sidekiq_options :retry => false
  include Importv3Helper

  def perform(importsession_id)
	set_group(importsession_id)
	sort_items
	Group.set_new_item_time
  end

end