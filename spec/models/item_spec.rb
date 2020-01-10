require 'rails_helper'
describe Item do
  describe '#create' do
    it "is valid all data" do
      item = build(:item)
      item.valid?
      expect(item).to be_valid
    end

    # 2. nameが空では登録できないこと
    it "is invalid without a name" do
      item = build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    # 3. textが空では登録できないこと
    it "is invalid without a text" do
      item = build(:item, text: "")
      item.valid?
      expect(item.errors[:text]).to include("を入力してください")
    end

    # 4. condition_idが空では登録できないこと
    it "is invalid without a condition_id" do
      item = build(:item, condition_id: nil)
      item.valid?
      expect(item.errors[:condition_id]).to include("を入力してください")
    end

    # 5. priceが空では登録できないこと
    it "is invalid without a price" do
      item = build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    # 6. category_idが空では登録できないこと
    it "is invalid without a category_id" do
      item = build(:item, category_id: "")
      item.valid?
      expect(item.errors[:category_id]).to include("を入力してください")
    end

    # 7. prefecture_idが空では登録できないこと
    it "is invalid without a prefecture_id" do
      item = build(:item, prefecture_id: "")
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    # 8. shipping_day_idが空では登録できないこと
    it "is invalid without a shipping_day_id" do
      item = build(:item, shipping_day_id: "")
      item.valid?
      expect(item.errors[:shipping_day_id]).to include("を入力してください")
    end

    # 9. priceが半角数字でなければ登録できないこと
    it "is invalid with a price that has only Half_size number" do
      item = build(:item, price: "あああ")
      item.valid?
      expect(item.errors[:price]).to include("半角数字で入力してください")
    end
  end
end