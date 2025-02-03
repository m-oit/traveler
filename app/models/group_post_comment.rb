class GroupPostComment < ApplicationRecord
  belongs_to :group_post
  belongs_to :user
  
  validates :content, presence: true
end
