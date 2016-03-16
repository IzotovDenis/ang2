class Dashboard::Api::PricelistsController < Dashboard::ApiController
  respond_to :json
  include PricelistHelper

  def index
    @pricelist = Pricelist.last
    render :json => @pricelist
  end

  def show
    @pricelist = Pricelist.last
  end

  def create
    if PricelistWorker.perform_async
      render :json => {start: true}
    end
  end

end
