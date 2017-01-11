class ApiController < ApplicationController
	include ActivityHelper
	include OrdersHelper
	before_action :check_abb
  before_action :set_activi
  protected

  def check_abb
    if current_user
      @can_view_price = current_user.price_type
      ["buyer","dev","admin", "retail"].include?(current_user.role) ? @can_view_qty = true : @can_view_price = false
    else
      @can_view_price = 'retail'
      @can_view_qty = false
    end
  end
  
  def json_request?
    request.format.json?
  end

end
