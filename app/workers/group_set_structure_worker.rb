class GroupSetStructureWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  include Importv3Helper

  def perform(importsession_id)
	set_parent_group
	set_disabled_group
	Group.where.not(:importsession_id=>importsession_id).each do |group|
		group.set_disabled
	end
  end

end