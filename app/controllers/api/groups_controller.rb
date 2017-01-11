class Api::GroupsController < ApiController
	before_action :set_group, only: [:show]
  before_action :set_instock, only: [:show]
  after_action :set_activity, only: [:index, :show]
  include OrderItemsHelper
  respond_to :json

  def index
    @banners = Banner.all.select("id, image, location, label, link").group_by { |d| d[:location]  }
    @offers = Offer.all
    @items = Item.popular.limit(12).pg_result(@can_view_price,false, @can_view_qty)
    render :json => {
                :items => @items,
                :banners => @banners
              }
  end

  def tree
    respond_with Group.able.select("id, title, ancestry, site_title, items_count").order(:title)
  end

  def show
  	ids = @group.subtree_ids
    price = true if can? :view_price, Item
    @items = Item.where(:group_id=>@group.id).where(@instock).order("items.group_id, items.position").page(params[:page]).pg_result(@can_view_price,falses,@can_view_qty)
    @total_entries = Item.where(:group_id=>@group.id).where(@instock).count
    render :json => {
              :items => @items, 
              :group => {
                :title => @group.site_title,
                :id         => @group.id
                        },
              :total_entries => @total_entries
                    }
  end

  	private
	# Use callbacks to share common setup or constraints between actions.
	def set_group
	  @group = Group.find(params[:id])
    params[:instock] === "true" ? @instock = true : @instock = false
    puts @instock
	end

  def set_instock
    params[:instock] === "false" ? @instock = "" : @instock = "qty > 0"
  end

  def set_activity
    unless params[:page] 
      activity_save :controller=>controller_name, :action=>action_name, :group=>(@group.title if @group), :group_id=>(@group.id if @group), :page=>params[:page]
    end  
  end

end
