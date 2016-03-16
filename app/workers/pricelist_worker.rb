class PricelistWorker
  include Sidekiq::Worker
  include PricelistHelper


  def perform
		if Pricelist.where(:status=>"progress").empty?
			@pricelist = Pricelist.create(:status=>"progress")
			if create_pricelist
				@pricelist.size = File.size("public/sys/pricelist/ponomarev-pricelist.zip")
				@pricelist.status = "success"
			else
				@pricelist.status = "error"
			end
			@pricelist.save
		end
  end

end