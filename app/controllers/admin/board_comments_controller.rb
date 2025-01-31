class Admin::BoardCommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @board_comments = BoardComment.includes(:user, :group).all
  end

  def destroy
    @board_comment = BoardComment.find(params[:id])
    @board_comment.destroy
    redirect_to admin_board_comments_path, notice: 'コメントが削除されました。'
  end
end