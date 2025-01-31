Admin::BoardCommentsController
layout 'admin'
before_action :authenticate_admin!

module Admin
  class BoardCommentsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_group

    def destroy
      @group = Group.find(params[:group_id])
      @comment = @group.board_comments.find(params[:id])
  
      if current_user == @group.owner || current_user.admin?
        @comment.destroy
        redirect_to admin_group_path(@group), notice: 'コメントを削除しました。'
      else
        redirect_to admin_group_path(@group), alert: 'コメントを削除する権限がありません。'
      end
    end
  end

    private

    def set_group
      @group = Group.find(params[:group_id])
    end
  end
end