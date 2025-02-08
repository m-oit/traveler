class EventNotice < ApplicationRecord
  belongs_to :group
  has_many :event_notice_emails
  
  validates :title, presence: true
  validates :event_date, presence: true
end
