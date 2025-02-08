class UsersController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  before_action :set_user, only: [:likes, :show, :groups]

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page])
    @groups = @user.groups
  end

  def index
    @users = User.where.not(id: User.guest.id)
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

  def likes
    @user = User.find(params[:id])
    @liked_posts = @user.liked_posts
    @liked_group_posts = @user.group_favorites.includes(:group_post).map(&:group_post) 
  end

  def groups
    @groups = @user.groups
    @owned_groups = @user.owned_groups
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "退会手続きが完了しました。ご利用いただきありがとうございました！"
    redirect_to new_user_registration_path
  end

  def admin_or_signed_in?
    current_user.present? && current_user.admin?
  end

   private

   def set_user
    @user = User.find_by(:id => params[:id])
   end

   def user_params
    params.require(:user).permit(:name, :email, :profile_image)
   end

   def is_matching_login_user
    user = User.find_by(id: params[:id])
    puts "User: #{user.inspect}"
    puts "params[:id]: #{params[:id]}"
    unless user && user.id == current_user.id
      redirect_to user_path(current_user), alert: "You can only edit or view your own profile."
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end 

end

