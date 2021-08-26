class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :login_required

  def current_user 
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to root_path if current_user.nil?
    flash[:error] = 'Please log in or register to continue'
  end
end
