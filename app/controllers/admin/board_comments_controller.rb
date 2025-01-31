class Admin::BoardCommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    if params[:search].present?
      @board_comments = BoardComment.includes(:user, :group).where('body LIKE ?', "%#{params[:search]}%")
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