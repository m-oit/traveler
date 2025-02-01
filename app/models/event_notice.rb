class EventNotice < ApplicationRecord
  belongs_to :group
  
  validates :title, presence: true
  validates :event_date, presence: true
end
