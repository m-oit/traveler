class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:email]

  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/profile.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
    end
    
    def self.guest
      find_or_create_by!(email: 'guest@example.com') do |user|
        user.password = SecureRandom.urlsafe_base64
        user.name = "ゲスト"
    end
  end
  

  validates :name, presence: true
  validates :email, presence: true
  end
