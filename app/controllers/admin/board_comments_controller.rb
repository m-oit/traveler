class Admin::BoardCommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index

    @board_comments = BoardComment.includes(:user).order(created_at: :desc)
    @group_post_comments = GroupPostComment.includes(:user, group_post: :group).order(created_at: :desc)


    if params[:search].present?
      @board_comments = @board_comments.joins(:user).where('users.name LIKE ? OR board_comments.body LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
      @group_post_comments = @group_post_comments.joins(:user, group_post: :group).where('users.name LIKE ? OR group_post_comments.content LIKE ? OR groups.name LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end


  def destroy
    @board_comment = BoardComment.find(params[:id])
    @group = @board_comment.group
    @board_comment.destroy
    redirect_to admin_board_comments_path, notice: 'コメントが削除されました'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end