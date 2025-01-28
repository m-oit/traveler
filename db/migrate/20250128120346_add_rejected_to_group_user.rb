class AddRejectedToGroupUser < ActiveRecord::Migration[6.1]
  def change
    add_column :group_users, :rejected, :boolean
  end
end
