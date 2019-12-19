# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# DB設計
<img width="1170" alt="DB設計図 2019-12-19 20 18 00" src="https://user-images.githubusercontent.com/57927432/71171261-af564600-22a0-11ea-8298-12155d2bed17.png">

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|nickname|string|null: false, unique: true|
|email|string|null: false, unique: true, default: ""|
|gender|integer|--|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
|phone_authy|string|null: false, unique: true, limit: 11|
|introduction|text|--|
|birth_day|integer|null: false|
|icon_image|string|--|
|encrypted_password|string|null: false, default: ""|
|reset_password_token|string|--|
|reset_password_sent_at|datetime|--|
|remember_created_at|datetime|--|

#### Association
- has_one :address, dependent: :destroy
- has_one :card, dependent: :destroy
- has_many :comments
- has_many :reviews
- has_many :favorites
- has_many :favorite_items  through: :favorites, source: :item
- has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
- has_many :selling_items, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Item"
- has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Item"

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|zip_code|string|null: false|
|prefecture|integer|null: false|
|city|string|null: false|
|block|string|null: false|
|building|string||
|phone|string||

#### Association
- belongs_to :user


## cardsテーブル(gem 'payjp'を使用)
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|

#### Association
- belongs_to :user

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true, index:true|
|text|string|null: false|
|price|integer|null: false|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|foreign_key: true|
|condition_id|references|null: false, foreign_key: true|
|postage_id|references|null: false, foreign_key: true|
|shipping_method_id|references|null: false, foreign_key: true|
|shipping_area_id|references|null: false, foreign_key: true|
|shipping_day_id|references|null: false, foreign_key: true|
|item_image_id|references|null: false, foreign_key: true|
|buyer_id|references|null: false, foreign_key: true|
|seller_id|references|null: false, foreign_key: true|
|encrypted_password|string|null: false, default: ""|
|reset_password_token|string|--|
|reset_password_sent_at|datetime|--|
|remember_created_at|datetime|--|

#### Association
- belongs_to :category
- belongs_to :brand
- belongs_to :condition
- belongs_to :postage
- belongs_to :shipping_method
- belongs_to :shipping_area
- belongs_to :shipping_day
- has_one :review
- has_many :item_images
- has_many :comment
- has_many :favorites, foreign_key: 'User_id', dependent: :destroy
- has_many :users, through: :favorites
- belongs_to :buyer, class_name: "User"
- belongs_to :seller, class_name: "User"

## favoritesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

#### Association
- belongs_to :user
- belongs_to :item


## categoriesテーブル(gem 'ancestry'を使用)
|Column|Type|Options|
|------|----|-------|
|name|references|null: false, foreign_key: true|
|ancestry|string||

#### Association
- has_many :items
- has_ancestry


## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||

#### Association
- has_many :items


## sizesテーブル
|Column|Type|Options|
|------|----|-------|
|size|string||

#### Association
- has_many :items


## conditionsテーブル
|Column|Type|Options|
|------|----|-------|
|condition|string|null: false|

#### Association
- has_many :items


## postagesテーブル
|Column|Type|Options|
|------|----|-------|
|burden|string|null: false|

#### Association
- has_many :items

## shipping_methodsテーブル
|Column|Type|Options|
|------|----|-------|
|method|string|null: false|

#### Association
- has_many :items


## shipping_areasテーブル
|Column|Type|Options|
|------|----|-------|
|prefecture|string|null: false|

#### Association
- has_many :items


## shipping_daysテーブル
|Column|Type|Options|
|------|----|-------|
|day|string|null: false|

#### Association
- has_many :items


## item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|item_id|references|null: false, foreign_key: true|

#### Association
- belongs_to :item

## reviewsテーブル
|Column|Type|Options|
|------|----|-------|
|rate|integer||
|comment|text||
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

#### Association
- belongs_to :user
- belongs_to :item


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text||
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

#### Association
- belongs_to :user
- belongs_to :item