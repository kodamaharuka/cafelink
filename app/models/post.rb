class Post < ApplicationRecord
  attachment :image
  
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :cafe_name, presence: true, length: { maximum: 15 }
  validates :introduction, presence: true, length: { maximum: 150 }
  validates :image, presence: true
  
  # ユーザーがつぶやきをお気に入りしているかどうかの判定メソッド
  def post_liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
  
end
