class Dashboard::Api::FilesController < Dashboard::ApiController
  respond_to :json

  def show

  end 

  def update

  end

  def create
  	@file = Ffile.new
  	@file.folder_id = params[:folder_id]
  	@file.file = params[:file]
  	@file.save
		render :json => @file
  end

end
