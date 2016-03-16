class Dashboard::Api::UsersController < Dashboard::ApiController
  respond_to :json
  before_action :set_user, :only=>[:show, :update, :update_role]
  def index
    if params[:role]
      @users = User.where(:role=>params[:role])
    else
      @users = User.all
    end
  end

  def show
  	respond_with @user
  end

  def update
    if @user.update(user_params)
      @status = true
    else
      @status = false
    end
  end

  def update_role
    if @user.update_attribute('role', params[:role])
      if params[:confirm]
        UserMailer.change_role(@user).deliver
      end
      render :json => {:status => "success", :role => @user.role}
    end
  end

  protected

  	def set_user
  	 @user = User.find(params[:id])
  	end

  def user_params
    @params = params.require(:user).permit( :person,
                                            :phone, 
                                            :city, 
                                            :name, 
                                            :legal_address,
                                            :actual_address, 
                                            :kpp, 
                                            :bank_name, 
                                            :curr_account, 
                                            :corr_account,
                                            :bik,
                                            :ogrn,
                                            :note,
                                            :inn)
  end

end
