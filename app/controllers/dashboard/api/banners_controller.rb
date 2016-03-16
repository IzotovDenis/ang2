class Dashboard::Api::BannersController < Dashboard::ApiController
  respond_to :json
  before_action :set_banner, only: [:show, :destroy, :update]
  #before_action :new_banner, only: [:create]

  def index
    @banners = Banner.all.select('location, id, position, label, image').group_by { |d| d[:location]  }
    render :json => @banners
  end

  def show
    respond_with @banners
  end

  def update
    @banner.update(banner_params)
    render :json => @banner
  end

  def create
    @banner = Banner.new(banner_params)
    if @banner.save
      render :json => @banner
    end
  end

  def sort
    params[:banners].each_with_index do |id,index|
      banner = Banner.find_by_id(id)
      banner.update_attribute('position',index+1)
    end
    render :json => {"success" => true}
  end

  def destroy
    if @banner.destroy
      @banners = Banner.all.order(:position)
      render :json => @banners
    end
  end
    private
  # Use callbacks to share common setup or constraints between actions.
  def set_banner
    @banner = Banner.find(params[:id])
  end

  def banner_params
    params.require(:banner).permit(:image, :link, :location, :label)
  end

  def new_banner
    @banner = Banner.new
    @banner.image = banner_params['image']
    @banner.link = banner_params['link']
    @banner.location = banner_params['location']
    @banner
  end

end
