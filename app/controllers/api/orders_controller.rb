class Api::OrdersController < ApiController
  respond_to :json
  before_action :set_order, only: [:show]
  load_and_authorize_resource only: [:index,:forwarding,:show]
  after_action :set_activity, only: [:add_items, :delete_items]

  def index
    @orders = Order.where(:user_id=>current_user.id).where("formed IS NOT NULL").select("total, to_char(formed , 'DD.MM.YYYY HH24:MI:SS') as date, id").order("formed DESC").page(params[:page])
    @count = Order.where(:user_id=>current_user.id).where("formed IS NOT NULL").count
    render :json=>{:orders=>@orders,:orders_count=>@count}
  end

  def current
    @order = current_order
    if params[:type] == "ids"
      render :json => @order.order_list
    else
      @order_items = Order.show_list(current_order.id) if @order
      render :json => @order_items
    end
  end

  def add_items
    @order = current_order
    ids = params[:items]
    @items = Item.where("id IN (?)", ids.keys).select("id")
    @old_items = @order.order_list.dup
    @items.each do |item|
      @order.order_list[item.id] = {'qty'=>ids[item.id.to_s].to_i}
    end
    if @order.save
      render :json => {'success'=> true, 'items' => @order.order_list}
    end
    @new_items = @order.order_list.dup
  end

  def delete_items
    @order = current_order
    @old_items = @order.order_list.dup
    ids = params[:items]
    ids.each do |id|
      @order.order_list.delete(id)
    end
      if @order.save
        render :json => {'success'=> true, 'items' => @order.order_list}
      end
    @new_items = @order.order_list.dup
  end

  def show
    @order = Order.show_list(params[:id])
    render :json => @order
  end
  
  def forwarding
  	@order = current_order
  	if @order.good?
      @order.comment = params[:comment]
      if @order.complete
  		  ForwardingWorker.perform_async(@order.id)
  		  render :json => {status: "success"}
      end
  	else
  		render :json => {status: "error"}
  	end
  end

    private
  # Use callbacks to share common setup or constraints between actions.
  def set_activity
    activity_save :controller=>controller_name, :action=>action_name,  :old_items=>@old_items, :new_items=>@new_items, :path=>URI(request.referer).path
  end

  def set_order
    # @order = Order.find(params[:id])
  end
end
