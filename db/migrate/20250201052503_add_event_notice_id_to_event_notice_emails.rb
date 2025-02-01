class AddEventNoticeIdToEventNoticeEmails < ActiveRecord::Migration[6.1]
  def change
    add_column :event_notice_emails, :event_notice_id, :integer
  end
end
