class AddGroupPostIdToGroupFavorites < ActiveRecord::Migration[6.1]
  def change
    add_column :group_favorites, :group_post_id, :integer
  end
end
