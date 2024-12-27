class PostImagesController < ApplicationController

  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path
    else
      render :new
    end
  end

  def index
    @post_images = PostImage.page(params[:page])
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    @post_image = PostImage.find(params[:id])
    if @post_image.update(post_image_params)
      redirect_to @post_image, notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  
  def destroy
    post_image = PostImage.find(params[:id])
    if post_image.user == current_user
    post_image.destroy
    flash[:notice] = "投稿画像を削除しました。"
    else
    flash[:alert] = "この投稿を削除する権限がありません。"
    end
    redirect_to user_path(post_image.user)
  end

  private

  def post_image_params
    params.require(:post_image).permit(:title, :image, :caption)
  end

  def is_matching_login_user
    @post_image = PostImage.find(params[:id])
    if @post_image.user != current_user
      redirect_to post_images_path, alert: "他のユーザーの投稿を編集・削除する権限がありません。"
    end
  end

end
