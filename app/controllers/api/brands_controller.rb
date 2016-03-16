# coding: utf-8
class Api::BrandsController < ApiController
  respond_to :json
	before_action :set_brand, only: [:show]

  def index
    @brands = Brand.all
    render :json => @brands
  end

  def show
    if !params[:page]
    @groups = Group.able.joins(:items).where("LOWER(items.brand) = ?", @brand.title.mb_chars.downcase.to_s.strip).uniq
  	end
    if params[:group_id]
      @items = Item.able.includes(:prices).where("LOWER(brand) = ?", @brand.title.mb_chars.downcase.to_s.strip).where(:group_id=>params[:group_id]).page(params[:page])
    else
      @items = Item.able.includes(:prices).where("LOWER(brand) = ?", @brand.title.mb_chars.downcase.to_s.strip).page(params[:page])
    end
  end


  private

  	def set_brand
  		@brand = Brand.find(params[:id])
  	end
end


