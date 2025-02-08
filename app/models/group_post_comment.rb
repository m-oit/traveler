class GroupPostComment < ApplicationRecord
  belongs_to :group_post
  belongs_to :user
  belongs_to :group
  
  validates :content, presence: true
end
