class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_day
  belongs_to :category
  has_one :review
  has_many :comments
  has_many :favorites, foreign_key: 'User_id', dependent: :destroy
  has_many :users, through: :favorites
  has_many :images, dependent: :destroy
  has_many_attached :images
  belongs_to :buyer, class_name: "User", optional: true
  belongs_to :seller, class_name: "User"
  validates :name, :text ,presence: true
  accepts_nested_attributes_for :images, allow_destroy: true
end
