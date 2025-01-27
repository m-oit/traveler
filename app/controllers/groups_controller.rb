class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :permits]

  def new
    @group =Group.new
  end

  def index
    @post_image = PostImage.new
    if params[:search].present?
      @groups = Group.joins(:owner).where('groups.name LIKE ? OR users.name LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @groups = Group.all
    end
  end

  def show
    @group = Group.find(params[:id])
    @group_posts = @group.group_posts
    @group_post = @group.group_posts.new
    @group_posts.each do |group_post|
      group_post.user ||= User.new
    end
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

