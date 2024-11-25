class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :post_images, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
  
end
