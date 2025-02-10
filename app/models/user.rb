class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:email]

  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :group_post_comments, dependent: :destroy
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :liked_posts, through: :favorites, source: :post_image
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :permits, dependent: :destroy
  has_many :board_comments, dependent: :destroy
  has_many :event_notice_emails, dependent: :destroy
  has_many :owned_groups, class_name: 'Group', foreign_key: 'owner_id'
  has_many :group_favorites, dependent: :destroy
  has_many :group_posts, dependent: :destroy


  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/profile.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

    def self.search_for(content, method)
      if method == 'perfect'
        User.where(name: content)
      elsif method == 'forward'
        User.where('name LIKE ?', content + '%')
      elsif method == 'backward'
        User.where('name LIKE ?', '%' + content)
      else
        User.where('name LIKE ?', '%' + content + '%')
      end
    end
    
    GUEST_USER_EMAIL = "guest@example.com"

    def self.guest
      find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
        user.password = SecureRandom.urlsafe_base64
        user.name = "guestuser"
      end
    end

    def guest_user?
      email == GUEST_USER_EMAIL
    end
  
    def follow(user)
      active_relationships.create(followed_id: user.id)
    end

    def unfollow(user)
      active_relationships.find_by(followed_id: user.id).destroy
    end

    def following?(user)
      followings.include?(user)
    end


  validates :name, presence: true
  validates :email, presence: true

  before_destroy :transfer_group_ownership

  private

  def transfer_group_ownership
    owned_groups.each do |group|

      new_owner = group.group_users.where.not(user_id: id).first&.user
  
      if new_owner

        group.update(owner_id: new_owner.id)
      elsif group.group_users.count > 1

        new_owner = group.group_users.where.not(user_id: id).first&.user
        group.update(owner_id: new_owner.id) if new_owner
      else

        group.destroy
      end
    end
  end

end

