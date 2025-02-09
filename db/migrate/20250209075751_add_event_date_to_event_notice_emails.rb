class AddEventDateToEventNoticeEmails < ActiveRecord::Migration[6.1]
  def change
    add_column :event_notice_emails, :event_date, :datetime
  end
end
