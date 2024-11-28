class UsersController < ApplicationController
  protect_from_forgery

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def show
     @user = User.find(params[:id])
     @post_images = @user.post_images.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user), notice: 'プロフィールが更新されました！'
    else
    render :edit
    end
  end

  def destroy
  end
  
   private
   
   def user_params
    params.require(:user).permit(:name, :email, :profile_image)
   end
end

