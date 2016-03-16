class ImportsController < ApplicationController
	include ImportsHelper
  include Importv3Helper #Import catalog
	skip_before_filter :verify_authenticity_token
  http_basic_authenticate_with name: "dhh", password: "secret1", only: :index

  def index
    if %w(checkauth init).include? params[:mode]
      send(params[:mode])
    elsif (%w(file import).include? params[:mode]) && (@imp_session = Importsession.find_by(:cookie=>cookies[:import_cookie]))
      send(params[:mode], @imp_session)
    else
      render :text => "wrong response\n"
    end
  end

  private 

  def checkauth
  	cookie = Importsession.create!(:cookie=>set_cookie,:exchange_type=>params[:exchange_type])
  	render :text => "success\nimport_cookie\n#{cookie.cookie}\n"
  end
  
  def init
    render :text => "zip=yes\nfile_limit=20857600"
  end 

  def file(imp_session)
		tempfile = Tempfile.new("importupload")
		tempfile.binmode
		tempfile << request.body.read
		tempfile.rewind
		import_params = params.slice(:filename, :type, :head).merge(:tempfile => tempfile)
		importf = ActionDispatch::Http::UploadedFile.new(import_params)
		@import = Import.new
		@import.filename = importf
		@import.importsession = imp_session
		@import.save
  	render :text => "success\n"
  end

  def import(imp_session)
    @importsession = imp_session
    unless @importsession.status == 'progress' || @importsession.status == 'success'
      @importsession.status = 'progress'
      @importsession.save
      ImportWorker.perform_async(@importsession.id)
    end
    sleep 10 if @importsession.status == "progress"
    render :text => "#{@importsession.status}\n"
  end
end


