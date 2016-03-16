class SearchWorker
  include Sidekiq::Worker

  def perform(hash)
  	  	Search.create!(hash)
  end
end