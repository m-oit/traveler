class GroupPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :set_group_post, only: [:edit, :update, :destroy]

  def new
    @group_post = @group.group_posts.new
  end

  def create
    @group_post = @group.group_posts.new(group_post_params)
    @group_post.user = current_user

    if @group_post.save
      redirect_to group_group_post_path(@group, @group_post), notice: '投稿が成功しました'
    else
      render :new
    end
  end

  def index
  end

  def show
    @group = Group.find(params[:group_id]) 
    @group_post = @group.group_posts.find_by(id: params[:id])
    
    if @group_post.nil?
      redirect_to group_group_posts_path(@group), alert: '投稿が見つかりません。'
    else
      @group_post_comments = @group_post.group_post_comments
      @group_post_comment = GroupPostComment.new 
      @group_posts = @group.group_posts.order(created_at: :desc).limit(3)
      @all_group_posts = @group.group_posts.order(created_at: :desc)
    end
  end
  


  def edit

  end

  def update
    if @group_post.update(group_post_params)
      redirect_to group_group_post_path(@group, @group_post), notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @group_post = @group.group_posts.find(params[:id])

    if current_user == @group_post.user || current_user == @group.owner
      @group_post.destroy
      redirect_to group_path(@group), notice: '投稿が削除されました。'
    else
      redirect_to group_path(@group), alert: '権限がありません。'
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_group_post
    @group_post = @group.group_posts.find(params[:id])
  end

  def group_post_params
    params.require(:group_post).permit(:title, :body, :image)
  end
end