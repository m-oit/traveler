class AddBodyToGroupPostComments < ActiveRecord::Migration[6.1]
  def change
    add_column :group_post_comments, :body, :text
  end
end
