class GroupPostCommentsController < ApplicationController
  before_action :set_group_post_comment, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    group_post = GroupPost.find(params[:group_post_id])
    comment = current_user.group_post_comments.new(group_post_comment_params)
    comment.group_post_id = group_post.id 
    comment.group_id = params[:group_id]
    if comment.save!
    redirect_to group_group_post_path(group_post.group, group_post)
  else
    redirect_to group_group_post_path(group_post.group, group_post)
  end
  end

  def show
    @group_post_image = GroupPost.find(params[:id])
    @group_post = @group.group_posts.find(params[:id])
    @group_post_comment = GroupPost.new
    @comments = @group_post.group_post_comments 
  end


  def destroy
    @group_post_comment = GroupPostComment.find(params[:id])
    if @group_post_comment.destroy
      redirect_to group_group_post_path(@group_post_comment.group_post.group, @group_post_comment.group_post), notice: "コメントが削除されました。"
    else
      redirect_to group_group_post_path(@group_post_comment.group_post.group, @group_post_comment.group_post), alert: "コメントの削除に失敗しました。"
    end
  end

  def edit
    @group_post = @group_post_comment.group_post 
  end

  def update
    if @group_post_comment.update(group_post_comment_params) 
      redirect_to group_group_post_path(@group_post_comment.group_post.group, @group_post_comment.group_post), notice: "コメントを更新しました。"
    else
      @group_post = @group_post_comment.group_post 
      flash.now[:alert] = "コメントの更新に失敗しました。" 
      render :Edit
    end
  end

  private

  def set_group_post_comment
    @group_post_comment = GroupPostComment.find_by(id: params[:id], group_post_id: params[:group_post_id])  
    unless @group_post_comment
      redirect_to root_path, alert: "コメントが見つかりませんでした。"
    end
  end

  def correct_user
    unless @group_post_comment.user == current_user || @group_post_comment.group_post.group.owner == current_user
      redirect_to group_group_post_path(@group_post_comment.group_post.group, @group_post_comment.group_post), alert: "コメントを削除する権限がありません。"
    end
  end

  def group_post_comment_params
    params.require(:group_post_comment).permit(:content, :group_id)
  end
end