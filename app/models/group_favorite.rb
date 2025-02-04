class GroupFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :group_post

  validates :user_id, uniqueness: {scope: :post_image_id}

end
