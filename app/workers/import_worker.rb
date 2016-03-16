class ImportWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  include Importv3Helper

  def perform(importsession_id,change=true)
  	@importsession = Importsession.find_by_id(importsession_id) || Importsession.create(:status=>'progress',:cookie=>"Full")
  		if change
			system ("cat public/uploads/imports/#{@importsession.id.to_s}/imp.zip.* > public/uploads/imports/#{@importsession.id.to_s}/import.zip")
			system ("unzip public/uploads/imports/#{@importsession.id.to_s}/import.zip -d public/uploads/imports/#{@importsession.id.to_s}/")
			@path = "public/uploads/imports/#{@importsession.id.to_s}"
		else
			system ("mkdir -p public/uploads/imports/#{@importsession.id.to_s}/")
			system ("unzip public/uploads/basic/import.zip -d public/uploads/imports/#{@importsession.id.to_s}/")
			@path = "public/uploads/imports/#{@importsession.id.to_s}/"
			#@path = "/media/1C5E04585E042CD8/1cbitrix"
		end
		if import1c(@importsession.id)
			@importsession.status = 'success'
			@importsession.save
		end
  end

end