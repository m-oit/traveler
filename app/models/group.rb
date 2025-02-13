class Group < ApplicationRecord
    has_one_attached :post_image
    belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
    has_many :group_users, dependent: :destroy
    has_many :users, through: :group_users
    has_many :board_comments, dependent: :destroy
    has_many :group_posts, dependent: :destroy
    has_many :permits, dependent: :destroy
    has_many :event_notices, dependent: :destroy
    has_many :event_notice_emails, dependent: :destroy
    has_many :group_post_comments, dependent: :destroy
    has_many :members, through: :group_users, source: :user
  
    validates :name, presence: true
    validates :introduction, presence: true
    validates :owner_id, presence: true
  
    def get_image
      (post_image.attached?) ? post_image : 'no_image.jpg'
    end
  
    def is_owned_by?(user)
      owner.id == user.id
    end

    def includesUser?(user)
      group_users.exists?(user_id: user.id)
    end
    
  end
