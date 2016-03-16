class Dashboard::Api::FoldersController < Dashboard::ApiController
  respond_to :json
  before_action :set_folder, only:  [:show, :update, :destroy]

  def index
    @folders = Folder.select("id, name, ancestry").arrange_serializable
    render :json => @folders
  end

  def show
    @files = @folder.ffiles
    render :json => @files
  end 

  def update

  end

  def create
    @folder = Folder.create(folder_params)
    render :json => @folder
  end

  private

  def set_folder
    @folder = Folder.find(params[:id])
  end

  def folder_params
    @params = params.require(:folder).permit(:name, :parent_id)
  end

end
