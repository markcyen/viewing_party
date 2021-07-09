class SessionsController < ApplicationController
  def create
    found_user = User.find_by(email: params[:email])
    if found_user && found_user.authenticate(params[:password])
      session[:user_id] = found_user.id
      redirect_to "/dashboard"
      # flash[:success] = "Welcome, #{found_user.email}!"
    else 
      flash[:error] = "Your email or password are incorrect!"
      redirect_to "/login"
    end 
  end 

  def destroy
    session[:user_id] = nil
    redirect_to root_path
 end
end
