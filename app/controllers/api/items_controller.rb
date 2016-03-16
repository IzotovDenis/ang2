# coding: utf-8
class Api::ItemsController < ApiController
  respond_to :json
	before_action :set_item, only: [:show, :edit, :update, :destroy]

  def show
    render :json => @item
  end

  def range
  	range = (params[:start]..params[:end]).to_a
  	@items = Item.where("properties -> 'Код товара' IN (?)", range)
  end

  def recent
  	@offers = Offer.all
  	@items = Item.where("label ? :key", :key=>"new").includes(:group)
  end

  def newest
    @items = Item.where('items.created_at > ?', Time.now-30.days).order("items.created_at").page(params[:page]).pg_result(@can_view_price)
    @items_count = Item.where('items.created_at > ?', Time.now-30.days).count
    render :json => {:items => @items, :total_items=> @items_count}
  end

	private
	# Use callbacks to share common setup or constraints between actions.
		def set_item
		@item = Item.where("properties -> 'Код товара' = :value", :value=>params[:id]).pg_result(@can_view_price,true).first
		end
end