class RelationshipsController < ApplicationController

  before_action :authenticate_user!
  
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end
  
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to  request.referer
  end
  
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
    @followings = user.followings
  end
  
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
    @followings = @user.followings
  end
end
