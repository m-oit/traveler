class AddTitleAndCaptionToPostImages < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:post_images, :title)
    add_column :post_images, :title, :string
    end 
    unless column_exists?(:post_images, :caption)
    add_column :post_images, :caption, :text
    end
  end
end
