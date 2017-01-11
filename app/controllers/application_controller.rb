class ApplicationController < ActionController::Base
  include OrdersHelper
  include ActivityHelper
  # before_filter :miniprofiler
  rescue_from CanCan::AccessDenied do |exception|
    render :json => {"error"=>exception.message}
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_activity

  layout :layout_by_resource

  protected

    def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:inn, :email, :password, :password_confirmation, :remember_me,:role, :person, :city, :name, :legal_address, :actual_address,
        :kpp, :bank_name,:curr_account,:corr_account,:bik, :phone, :note, :ogrn) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:inn, :email, :password, :password_confirmation, :current_password) }
  end

  def miniprofiler
    if current_user
      Rack::MiniProfiler.authorize_request if current_user.dev?
    end
  end

  def set_activity
    puts "============================="
    puts params
    puts "============================="
  end
end
