class Admin::GroupPostsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def show
    @group = Group.find(params[:group_id])
    @group_post = @group.group_posts.find(params[:id])
  end
  
end
