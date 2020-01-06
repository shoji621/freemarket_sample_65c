class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false, unique: true, index: true
      t.string :text, null: false
      t.integer :price, null: false
      t.references :category, foreign_key: true
      t.references :brand, foreign_key:true
      t.integer :condition_id, null: false
      t.integer :postage_id, null: false
      t.integer :shipping_method_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :shipping_day_id, null:false
      t.references :item_image, null:false, foreign_key: true
      t.references :buyer, null: false
      t.references :seller, null: false
      t.string :encrypted_password, null: false, default: ""
      t.string :reset_password
      t.datetime :reset_password_sent_at
      t.datetime :remenber_created_at
      t.timestamps
    end
  end
end
