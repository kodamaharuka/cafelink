class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  # フォロー機能
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :followings, through: :relationships, source: :followed
  has_many :posts, dependent: :destroy
 
  def follow(other_user)
    Relationship.create(follower_id:self.id,followed_id: other_user.id) 
  end

  def unfollow(other_user)
    relationship = Relationship.find_by(follower_id:self.id,followed_id: other_user.id) 
    relationship.destroy if relationship
  end

  def following?(other_user)
    Relationship.exists?(follower_id:self.id,followed_id: other_user.id)
  end
  # ここまで/

  # 検索
  def self.search(search, user_or_comic, how_search)
    if user_or_comic == '1'
      if how_search == '1'
        User.where(['name LIKE ?', "%#{search}%"])
      elsif how_search == '2'
        User.where(['name LIKE ?', "%#{search}"])
      elsif how_search == '3'
        User.where(['name LIKE ?', "#{search}%"])
      elsif how_search == '4'
        User.where(['name LIKE ?', search.to_s])
      else
        User.all
      end
    end
  end

  # 画像投稿機能
  attachment :profile_image

  # バリデーション
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :introduction, length: { maximum: 300 }
end

 def self.guest
    find_or_create_by!(email: 'guest@example.com',name: 'ゲスト') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
  end
end