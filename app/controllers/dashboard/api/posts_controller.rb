class Dashboard::Api::PostsController < Dashboard::ApiController
  respond_to :json
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    @posts = Post.where.not(:block=>"company_block")
    @company_block = Post.where(:block=>"company_block").order("position ASC")
    render :json => {:company_block => @company_block, :others=> @PostsController}
  end

  def show
    render :json => @post
  end

  def update
    @post.update(post_params)
    render :json => @post
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      render :json => {"success" => true}
    end
  end

  def destroy
    if @post.destroy
      render :json => {"success" => true}
    end
  end

  def sort
    params[:posts].each_with_index do |id,index|
      post = Post.find_by_id(id)
      post.update_attribute('position',index+1)
    end
    render :json => {"success" => true}
  end

    private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :block, :text, :url)
  end
end
