class Dashboard::Api::OrdersController < Dashboard::ApiController
  respond_to :json
  before_action :set_order, only: [:show]

  def index
    if params[:user_id]
     @orders = Order.ready.where(:user_id=>params[:user_id]).order('formed DESC')
    else
      @start = Date.strptime(params[:date], '%Y-%m-%d').beginning_of_day
      case params[:period]
        when "day"
          @end = @start + 1.day
        when "week"
          @end = @start + 1.week
        when "month"
          @end = @start + 1.month
      end 
      @orders = Order.ready.where(:formed=>@start..@end).order('formed DESC')
    end
  end

  def show
    render :json => @order
  end

    private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    if params[:current]
      user = User.where(:id=>params[:id]).first
      if user
        @order = Order.show_list(user.current_order.id) if user.current_order
      end
    else
      @order = Order.show_list(params[:id])
    end
  end
end
