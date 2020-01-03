class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
  has_many :sns_credentials

  has_many :items
  has_one :card, inverse_of: :user
  
  VALID_EMAIL_REGEX =              /\A[\w+\-.]+@[\w+\-.]+\.[a-z]+$\z/
  # profile入力項目
  validates :nickname             , presence: true, uniqueness: true
  validates :email                , presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password             , presence: true, format: { with: /\A[a-zA-Z0-9]{7,}+$\z/, message: 'は7文字以上の半角英数字で入力してください'}
  validates :last_name            , presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角で入力してください'}
  validates :first_name           , presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角で入力してください'}
  validates :last_name_kana       , presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナで入力してください'}
  validates :first_name_kana      , presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナで入力してください'}
  validates :birthday             , presence: true

  # phone入力項目
  validates :phone_authy          ,presence: true ,format: { with: /\d{11}+\z/, message: 'は11桁の半角数字(ハイフンなし)で入力してください'}, on: :validates_phone


  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
