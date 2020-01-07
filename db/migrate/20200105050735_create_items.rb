class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false, unique: true, index: true
      t.string :text, null: false
      t.integer :price, null: false
      t.integer :category_id, foreign_key: true
      t.integer :condition_id, null: false
      t.integer :postage_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :shipping_day_id, null:false
      t.integer :buyer_id, foreign_key: true
      t.integer :seller_id, null:false, foreign_key: true
      t.timestamps
    end
  end
end
