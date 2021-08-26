class UsersController < ApplicationController
  skip_before_action :login_required, raise: false
  
  def new
    @user = User.new
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.create(user)
    if new_user.save
      session[:user_id] = new_user.id
      redirect_to dashboard_path
    else
      flash[:error] = "#{new_user.errors.full_messages.join}! Please try again!"
      redirect_to register_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
