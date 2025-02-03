class CreateGroupPostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :group_post_comments do |t|
      t.references :group_post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
