class Dashboard::ApiController < DashboardController
	respond_to :json

	def stat
		stat = Hash.new
		@activities = Activity.where.not(user_id: '').includes(:user).all.limit(20).order("updated_at DESC").limit(20)
		@online = User.online
		@noobs = User.noobs
		@orders = Order.ready.limit(10)
	end

end
