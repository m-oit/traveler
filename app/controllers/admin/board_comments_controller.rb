class Admin::BoardCommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @board_comments = BoardComment.all.includes(:user)
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