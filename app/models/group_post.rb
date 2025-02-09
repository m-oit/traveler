class GroupPost < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_one_attached :image
  has_many :group_post_comments, dependent: :destroy
  has_many :group_favorites, dependent: :destroy
  
  validates :image, presence: true


  def favorited_by?(user)
    group_favorites.exists?(user_id: user.id)
  end
end