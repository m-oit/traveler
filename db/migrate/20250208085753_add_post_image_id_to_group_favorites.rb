class AddPostImageIdToGroupFavorites < ActiveRecord::Migration[6.1]
  def change
    add_column :group_favorites, :post_image_id, :integer
  end
end
