class Admin::BoardCommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    if params[:search].present?
      @board_comments = BoardComment.joins(:user).where('board_comments.body LIKE ? OR users.name LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @board_comments = BoardComment.includes(:user, :group).all
    end
  end


  def destroy
    @board_comment = BoardComment.find(params[:id])
    @board_comment.destroy
    redirect_to admin_board_comments_path, notice: 'コメントが削除されました'
  end
end