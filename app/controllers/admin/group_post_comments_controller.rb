class Admin::GroupPostCommentsController < ApplicationController

  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @group_post_comments = GroupPostComment.includes(:user, :group_post).order(created_at: :desc)
  end

end
  