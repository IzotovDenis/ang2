# coding: utf-8
class Api::PostsController < ApiController
  respond_to :json
	before_action :set_post, only: [:show]

  def show
  	render :json => @post
  end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_post
	@post = Post.where(["id = :id OR lower(url) = :url", { :id => params[:id].to_i, :url => params[:id].to_s.downcase }]).select("text, title").first
	end
end
