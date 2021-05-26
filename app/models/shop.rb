class Shop < ApplicationRecord
  belongs_to :genre
  has_many :shop_images, dependent: :destroy
  
  attachment :image
  accepts_attachments_for :images, attachment: :image

  #geocoded_by :address
  #after_validation :geocode, if: :address_changed?

  validates :cafe_name, presence: true, length: { maximum: 30 }
  validates :address, presence: true
  validates :nearest_station, presence: true
  validates :business_hours, presence: true
  validates :regular_holiday, presence: true
  validates :introduction, presence: true, length: { maximum: 300 }
  validates :phone_number, presence: true
  validates :image, presence: true

  # ユーザーがお店をブックマークしているかどうかの判定メソッド
  def bookmarked_by?(member)
    bookmarks.where(member_id: member.id).exists?
  end
end
