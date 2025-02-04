class CreateGroupFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :group_favorites do |t|
      t.integer :user_id
      t.integer :post_image_id
      add_column :group_favorites, :group_post_id, :integer

      t.timestamps
    end
  end
end
