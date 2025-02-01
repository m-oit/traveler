class Admin::PostCommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @group = Group.find_by(id: params[:group_id])
    
    if params[:search].present?
      @post_comments = PostComment.joins(:user)
                                  .where('users.name LIKE ? OR post_comments.comment LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @post_comments = PostComment.includes(:user).all
    end
  end
  
  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    @post_comments = PostComment.includes(:user).all
    flash[:notice] = 'コメントを削除しました'
    render :index
  end
  
end

