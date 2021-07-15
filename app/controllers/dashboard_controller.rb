class DashboardController < ApplicationController
  def index
    @user = current_user
    # require 'pry';binding.pry
  end
end
