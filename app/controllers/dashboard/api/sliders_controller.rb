class Dashboard::Api::SlidersController < Dashboard::ApiController
  respond_to :json
  before_action :set_slider, only: [:show, :destroy]
  before_action :new_slider, only: [:create]

  def index
    @sliders = Slider.all.order(:position)
    respond_with @sliders
  end

  def show
    respond_with @sliders
  end

  def create
    @slider = new_slider
    if @slider.save
      render :json=>@slider
    end
  end

  def destroy
    if @slider.destroy
      @sliders = Slider.all.order(:position)
      respond_with @sliders
    end
  end
    private
  # Use callbacks to share common setup or constraints between actions.
  def set_slider
    @slider = Slider.find(params[:id])
  end

  def slider_params
    params.require(:slider).permit(:image, :link)
  end

  def new_slider
    @slider = Slider.new
    @slider.action = {}
    @slider.action["image"] = slider_params['image']
    @slider.action["link"] = slider_params['link']
    @slider
  end

end
