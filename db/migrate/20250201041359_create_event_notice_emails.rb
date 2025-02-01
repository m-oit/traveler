class CreateEventNoticeEmails < ActiveRecord::Migration[6.1]
  def change
    create_table :event_notice_emails do |t|
      t.references :group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
