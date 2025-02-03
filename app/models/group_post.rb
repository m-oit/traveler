class GroupPost < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_one_attached :image
  has_many :group_post_comments, dependent: :destroy

  validates :image, presence: true
end
