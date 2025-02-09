class RemoveDescriptionFromEventNoticeEmails < ActiveRecord::Migration[6.1]
  def change
    remove_column :event_notice_emails, :description, :text
  end
end
