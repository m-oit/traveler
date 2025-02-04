class AddCommentToGroupPostComments < ActiveRecord::Migration[6.1]
  def change
    add_column :group_post_comments, :comment, :text
  end
end
