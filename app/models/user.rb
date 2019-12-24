class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_one :address, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :address

  has_many :items
  has_one :card, inverse_of: :user
  
  VALID_EMAIL_REGEX =                 /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # profile入力項目
  validates :nickname             ,presence: true, uniqueness: true
  validates :email                ,presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password             ,presence: true, length: { minimum: 7, maximum: 128}
  validates :last_name            ,presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: '全角で入力してください'}
  validates :first_name           ,presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: '全角で入力してください'}
  validates :last_name_kana       ,presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :first_name_kana      ,presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :birthday             ,presence: true

  # phone入力項目
  validates :phone_authy          ,presence: true, length: {maximum: 11}, on: :validates_phone
end
