class Admin::PostCommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
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
    redirect_to admin_post_image_path(@post_comment.post_image), notice: 'コメントを削除しました'
  end
  
end

