class PostCommentsController < ApplicationController
    before_action :set_post_comment, only: [:edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update, :destroy]


def create
    post_image = PostImage.find(params[:post_image_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_image_id = post_image.id
    if comment.save
    redirect_to post_image_path(post_image)
  else
    flash[:alert] = "コメントを入力してください。"
    redirect_to post_image_path(post_image)
  end
end

def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_image_path(params[:post_image_id])
end

def edit
    @post_image = @post_comment.post_image
  end

  def update
    if @post_comment.update(post_comment_params)
      redirect_to post_image_path(@post_comment.post_image), notice: "コメントを更新しました。"
    else
      @post_image = @post_comment.post_image
      flash.now[:alert] = "コメントの更新に失敗しました。"
      render :edit
    end
  end

private

def set_post_comment
    @post_comment = PostComment.find_by(id: params[:id], post_image_id: params[:post_image_id])
    unless @post_comment
      redirect_to root_path, alert: "コメントが見つかりませんでした。"
    end
  end

  def correct_user
    if @post_comment.user != current_user
      redirect_to post_image_path(@post_comment.post_image), alert: "あなたはこのコメントを編集できません。"
    end
  end

def post_comment_params
    params.require(:post_comment).permit(:comment)
end

end
