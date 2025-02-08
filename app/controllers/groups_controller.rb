class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :permits]

  def new
    @group =Group.new
  end

  def index
    @groups = Group.all
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      GroupUser.create!(user_id: @group.owner_id, group_id: @group.id)
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:id])
    @group_posts = @group.group_posts
    @group_post = @group.group_posts.new
    @group_posts.each do |group_post|
      group_post.user ||= User.new
    end
    @is_owner_or_member = @group.is_owned_by?(current_user) || @group.includesUser?(current_user)
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, notice: 'グループが削除されました'
  end

  def permits
    @group = Group.find(params[:id])
    @permits = @group.permits.page(params[:page])
  end

  def group_likes
    @group = Group.find(params[:id])
    @group_likes = @group.group_favorites
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :post_image)
  end

  
  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path, alert: "グループオーナーのみ編集が可能です"
    end
  end
end

