class PostImage < ApplicationRecord

 has_one_attached :image
 belongs_to :user
 has_many :post_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
 has_many :liked_by_users, through: :favorites, source: :user
 has_many :group_favorites, dependent: :destroy


 validates :title, presence: true
 validates :image, presence: true
 
 
  def get_image
   unless image.attached?
     file_path = Rails.root.join('app/assets/images/profile.jpeg')
     image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
      image
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      PostImage.where(title: content)
    elsif method == 'forward'
      PostImage.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      PostImage.where('title LIKE ?', '%'+content)
    else
      PostImage.where('title LIKE ?', '%'+content+'%')
    end
  end
  
end
