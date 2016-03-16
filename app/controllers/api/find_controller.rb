# coding: utf-8
class Api::FindController < ApiController
  include FindHelper
  include EmexHelper
  after_action :set_activity
  respond_to :json
  def index
    @query = params[:query]
    @ids = Item.search_for_ids(str_query(params[:query], params[:attr]), set_options)
    @count = Item.search_for_ids(str_query(params[:query], params[:attr]), set_options_ids)
    @order = "idx(array#{@ids.to_s}, items.id)" if @count.length > 0
    @items = Item.where(:id=>@ids).order("#{@order}").pg_result(true)
    render :json => {:items=>@items, :total_entries=>@count.length}
  end

  private

  def set_activity
  activity_save :controller=>"find", :action=>action_name, :text=>@query, :result=>@count.length, :page=>params[:page]
  end

  def set_options
    options = {}
    options[:field_weights] = {:kod => 1000, :article => 60, :oem => 5,:full_name => 20}
    options[:order_by] = 'properties["Код товара"]'
    options[:per_page] = 60
    options[:with] = {:group_id => params[:group].to_i} if params[:group]
    options[:page] = params[:page]
    options
  end

  def set_options_ids
    options = set_options
    options[:page] = nil
    options[:per_page] = 1000
    options
  end

end