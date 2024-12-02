class Public::UsersController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update, :show]
  
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page])
  end

  def edit
   @user = User.find(params[:id])
  
  end
    
  def update
  @user = User.find(params[:id])
  is_matching_login_user
  if @user.update(user_params)
    redirect_to user_path(@user), notice: 'Profile updated successfully.'
  else
    render :edit
  end
end

   private

   def user_params
    params.require(:user).permit(:name, :email, :profile_image)
   end

   def is_matching_login_user
    user = User.find_by(id: params[:id])
    puts "User: #{user.inspect}"
    puts "params[:id]: #{params[:id]}"
    unless user && user.id == current_user.id
      redirect_to post_images_path, alert: "You can only edit or view your own profile."
    end
  end
end

