class EventNoticeEmail < ApplicationRecord
  belongs_to :group
  belongs_to :user
  belongs_to :event_notice, optional: true

  validates :title, presence: true
  validates :body, presence: true

end
