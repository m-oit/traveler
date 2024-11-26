class PostImagesController < ApplicationController
  protect_from_forgery
  
  
  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
    redirect_to post_images_path, notice: '投稿が完了しました！'
    else
    render :new, alert: '投稿に失敗しました。'
    end
  end

  def index
    @post_images = PostImage.all
  end

  def show
    @post_image = PostImage.find(params[:id])
  end
  
  def destroy
    post_image = PostImage.find(params[:id])
    if post_image.user == current_user
    post_image.destroy
    flash[:notice] = "投稿画像を削除しました。"
    else
    flash[:alert] = "この投稿を削除する権限がありません。"
    end
    redirect_to post_images_path
  end

  private

  def post_image_params
    params.require(:post_image).permit(:title, :image, :caption)
  end

end
