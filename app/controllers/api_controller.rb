class ApiController < ApplicationController
	include ActivityHelper
	include OrdersHelper
	before_action :check_abb
  protected

  def check_abb
    @can_view_price = current_user.price_type if current_user
  end
  
  def json_request?
    request.format.json?
  end
end
