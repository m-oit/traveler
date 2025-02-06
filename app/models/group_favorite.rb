class GroupFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :group_post

  validates :user_id, uniqueness: { scope: :group_post_id }

end
