class GroupPost < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
end
