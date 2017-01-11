class ApiController < ApplicationController
	include ActivityHelper
	include OrdersHelper
	before_action :check_abb
  protected

  def check_abb
    if current_user
      @can_view_price = current_user.price_type
      ["buyer","dev","admin", "retail"].include?(current_user.role) ? @can_view_qty = true : @can_view_price = false
    else
      @can_view_price = '0fa9bc8a-166f-11e0-9aa1-001e68eacf93'
      @can_view_qty = false
    end
  end
  
  def json_request?
    request.format.json?
  end

end
