class AddGroupIdToGroupPostComments < ActiveRecord::Migration[6.1]
  def change
    add_column :group_post_comments, :group_id, :integer
  end
end
