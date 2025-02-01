class Admin::GroupsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @groups = Group.includes(:owner)
    @group = Group.find_by(id: params[:group_id]) if params[:group_id].present?
  end

  def show
    @group = Group.find(params[:id])
    @group_posts = @group.group_posts.includes(:user)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path, notice: "グループを削除しました。"
  end
end