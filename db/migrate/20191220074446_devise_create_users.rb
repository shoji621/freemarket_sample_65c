# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      |last_name|string|null: false|
      |first_name|string|null: false|
      |last_name_kana|string|null: false|
      |first_name_kana|string|null: false|
      |nickname|string|null: false, unique: true|
      |email|string|null: false, unique: true, default: ""|
      |gender|integer||
      |birth_year|integer|null: false|
      |birth_month|integer|null: false|
      |birth_day|integer|null: false|
      |phone_authy|string|null: false, unique: true, limit: 11|
      |introduction|text||
      |birth_day|integer|null: false|
      |icon_image|string||

      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :last_name_kana, null: false
      t.string :first_name_kana, null: false
      t.string :nickname, null: false, unique: true
      t.string :email, null: false, default: ""
      t.inteder :gender
      t.string :last_name_kana, null: false
      t.string :first_name_kana, null: false
      t.inteder :birth_year, null: false
      t.inteder :birth_month, null: false
      t.inteder :birth_day, null: false
      t.string :phone_authy, null: false, unique: true, limit: 11
      t.text :introduction

      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
