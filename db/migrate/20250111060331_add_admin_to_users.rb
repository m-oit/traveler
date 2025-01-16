class AddAdminToUsers < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:users, :admin)
      add_column :users, :admin, :boolean
    end
    unless column_exists?(:users, :default)
      add_column :users, :default, :false
    end
  end
end
