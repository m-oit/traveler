class AddDetailsToPostImages < ActiveRecord::Migration[6.1]
  def change
    add_column :post_images, :title, :string
    add_column :post_images, :caption, :text
    add_column :post_images, :user_id, :integer
  end
end
