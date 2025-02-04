class GroupPostsController < ApplicationController
  before_action :set_group

  def new
    @group_post = @group.group_posts.new
  end

  def create
    @group_post = @group.group_posts.new(group_post_params)
    @group_post.user = current_user

    if @group_post.save
      redirect_to group_path(@group), notice: '画像が投稿されました。'
    else
      render :new
    end
  end

  def index

  end

  def show
    @group = Group.find(params[:group_id])
    @group_post = GroupPost.find(params[:id])
    @group_post_comment = GroupPostComment.new
    @group_post = @group.group_posts.find_by(id: params[:id])
    if @group_post.nil?
      redirect_to group_group_posts_path(@group), alert: '投稿が見つかりません。'
    else
      @group_post_comments = @group_post.group_post_comments
      @group_posts = @group.group_posts.order(created_at: :desc).limit(3)
      @all_group_posts = @group.group_posts.order(created_at: :desc)
    end
  end

  def destroy
    @group_post = @group.group_posts.find_by(id: params[:id])

    if @group_post.nil?
      redirect_to group_path(@group), alert: '投稿が見つかりません。'
      return
    end
  
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

  def group_post_params
    params.require(:group_post).permit(:image)
  end
end
