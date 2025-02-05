class GroupFavoritesController < ApplicationController

  def create
    group_post = GroupPost.find(params[:group_post_id])
    group_favorite = current_user.group_favorites.new(group_post_id: group_post.id)
    group_favorite.save
    redirect_to group_group_post_path(group_post.group, group_post)
  end

  def destroy
    group_post = GroupPost.find(params[:group_post_id])
    group_favorite = current_user.group_favorites.find_by(group_post_id: group_post.id)
    group_favorite.destroy
    redirect_to group_group_post_path(group_post.group, group_post)
  end
end