class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"

  def show
    @user = User.find(params[:id]) 
    @post_images = @user.post_images.page(params[:page])
  end

  def index
    @users = User.all
  end

  def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
  end
end
