class SessionsController < ApplicationController
  def new
  end
  
  def create
    found_user = User.find_by(email: params[:email])
    if found_user && found_user.authenticate(params[:password])
      session[:user_id] = found_user.id
      redirect_to "/dashboard"
      # flash[:success] = "Welcome, #{found_user.email}!"
    else 
      flash[:error] = "Either the email or password you have entered is incorrect!"
      redirect_to "/login"
    end 
  end 

  def destroy
    session[:user_id] = nil
    redirect_to root_path
 end
end
