class DashboardController < ApplicationController
  def index
    # binding.pry
    @user = current_user
  end
end
