# coding: utf-8
class Api::BookingController < ApiController
  respond_to :json
  include RosskoHelper

  def index
    render :json => rossco_requerst(params[:query])
  end

end
