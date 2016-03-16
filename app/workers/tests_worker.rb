class TestsWorker
  include Sidekiq::Worker

  def perform
	item = Item.first
	puts "START WORK"
	sleep 30
	puts "STOP"
  end
end