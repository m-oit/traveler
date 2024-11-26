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

  private

  def post_image_params
    params.require(:post_image).permit(:title, :image, :caption)
  end

end
