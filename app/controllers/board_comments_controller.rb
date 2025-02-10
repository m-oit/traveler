class BoardCommentsController < ApplicationController

  before_action :set_group

  def create
    @board_comment = @group.board_comments.build(board_comment_params)
    @board_comment.user = current_user

    if @board_comment.save
      redirect_to group_path(@group), notice: 'コメントを投稿しました。'
    else
      redirect_to group_path(@group), alert: 'コメントの投稿に失敗しました。'
    end
  end

  def destroy
    @board_comment = @group.board_comments.find(params[:id])
    if @board_comment.user == current_user || @group.owner == current_user
      @board_comment.destroy
      redirect_to group_path(@group), notice: 'コメントを削除しました。'
    else
      redirect_to group_path(@group), alert: '削除権限がありません。'
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def board_comment_params
    params.require(:board_comment).permit(:body)
  end
end
