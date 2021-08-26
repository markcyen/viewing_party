class FriendsController < ApplicationController
  def create
    @user = current_user
    friend = User.find_by(email: params[:email])

    if friend.present?
      if @user == friend
        flash[:notice] = 'You have entered your own email!'
      elsif @user.friends.include?(friend)
        flash[:notice] = 'You entered a friend who already exists on your list!'
      else !@user.friends.include?(friend)
        # @user.friendships.create!(friend: friend) {perhaps add friend.id}
        @user.friends.push(friend)
      end
    else
      flash[:error] = "Invalid Email!"
    end

    redirect_to '/dashboard'
  end
end