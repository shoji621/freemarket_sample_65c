class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_day
  belongs_to :category
  has_one :review
  has_many :comments
  has_many :favorites, foreign_key: 'Item_id', dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :users, through: :favorites
  has_many :images, dependent: :destroy
  belongs_to :buyer, class_name: "User", optional: true
  belongs_to :seller, class_name: "User", optional: true
  validates :name, :text, :condition_id, :price, :category_id, :prefecture_id, :shipping_day_id, presence: true
  validates_associated :images
  validates :price, format: { with: /\A([1-9]\d*,)*[1-9]\d*\z/, message: '半角数字で入力してください'}
  accepts_nested_attributes_for :images, allow_destroy: true

  def self.search(search)
    return Item.all unless search
    Item.where('name LIKE(?)', "%#{search}%")
  end

  def previous
    Item.where("id < ?", self.id).order("id DESC").first
  end

  def next
    Item.where("id > ?", self.id).order("id ASC").first
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
