class Dashboard::Api::OffersController < Dashboard::ApiController
  respond_to :json
  before_action :set_offer, only: [:show, :update, :destroy]

  include OffersHelper

  def index
    @offers = Offer.all
    respond_with @offers
  end

  def show

  end

  def new

  end

  def destroy
    destroy_offer_items(@offer.variant, @offer.id)
    @offer.destroy
    render :json => Offer.all
  end


  def update
    old_variant = @offer.variant
    if @offer.update(new_offer)
      destroy_offer_items(old_variant, @offer.id)
      set_offer_items(@offer.variant, @offer.id, items_ids)
    end
    render :json => @offer
  end

  def create
    @offer = Offer.new(new_offer)
    if @offer.save
      set_offer_items(@offer.variant, @offer.id, items_ids)
    end
    render :json => @offer
  end

  def get_items
    case params[:type]
      when "item_group"
        @items = Item.where(:group_id=>params[:group_id])
      when "item_range"
        range = (params[:from]..params[:to]).to_a
        @items = Item.where("properties -> 'Код товара' IN (?)", range)
      when "item_code"
        @items = Item.where("properties -> 'Код товара' = :value", :value=>params[:code])
      else
        @response = ""
      end
  end

    private
  # Use callbacks to share common setup or constraints between actions.
  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
      params.require(:offer).permit(:title, :text, :variant, :thumb)
  end

  def new_offer
    offer = {}
    offer['title'] = offer_params['title']
    offer['store'] = {}
    offer['store']['text'] = offer_params['text']
    offer['store']['thumb'] = offer_params['thumb']
    offer['variant'] = offer_params['variant']
    offer
  end

  def items_ids
    array = []
    if params[:offer][:items]
      params[:offer][:items].each do |item|
        array.push(item['kod'])
      end
    end
    array
  end

end
