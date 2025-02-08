class Admin::GroupPostCommentsController < ApplicationController

  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @group_post_comments = GroupPostComment.includes(:user, :group_post).order(created_at: :desc)
  end

  def destroy
    @group_post_comment = GroupPostComment.find(params[:id])
    @group_post_comment.destroy
    redirect_to admin_board_comments_path, notice: 'コメントが削除されました'
  end

end
  