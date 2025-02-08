class AddTitleAndBodyToGroupPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :group_posts, :title, :string
    add_column :group_posts, :body, :text
  end
end
