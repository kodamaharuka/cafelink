class Post < ApplicationRecord
  attachment :image
  
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :tags, dependent: :destroy


  validates :cafe_name, presence: true, length: { maximum: 15 }
  validates :introduction, presence: true, length: { maximum: 150 }
  validates :image, presence: true
end
