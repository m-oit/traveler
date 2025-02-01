class Admin::BoardCommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :set_group, only: [:index]

  def index
    @group = Group.find(params[:group_id])
    logger.debug "Group ID: #{@group.id}"
    if params[:search].present?
      @board_comments = BoardComment.joins(:user).where('board_comments.body LIKE ? OR users.name LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @board_comments = BoardComment.includes(:user, :group).all
    end
  end


  def destroy
    @board_comment = BoardComment.find(params[:id])
    @group = @board_comment.group
    @board_comment.destroy
    redirect_to admin_group_board_comments_path(@group), notice: 'コメントが削除されました'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end