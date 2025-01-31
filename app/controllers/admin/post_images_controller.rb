class Admin::PostImagesController < ApplicationController
  layout 'admin'

  def show
    @post_image = PostImage.find(params[:id])
  end
  
end
