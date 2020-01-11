require 'rails_helper'
describe Item do
  describe '#create' do
    # 1. nameが空では登録できないこと
    it "is invalid without a name" do
      user = create(:user)
      item = build(:item, name: nil, buyer_id: user.id)
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    # 2. textが空では登録できないこと
    it "is invalid without a text" do
      user = create(:user)
      item = build(:item, text: nil, buyer_id: user.id)
      item.valid?
      expect(item.errors[:text]).to include("を入力してください")
    end

    # 3. condition_idが空では登録できないこと
    it "is invalid without a condition_id" do
      user = create(:user)
      item = build(:item, condition_id: nil, buyer_id: user.id)
      item.valid?
      expect(item.errors[:condition_id]).to include("を入力してください")
    end

    # 4. priceが空では登録できないこと
    it "is invalid without a price" do
      user = create(:user)
      item = build(:item, price: nil, buyer_id: user.id)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    # 5. category_idが空では登録できないこと
    it "is invalid without a category_id" do
      user = create(:user)
      item = build(:item, category_id: nil, buyer_id: user.id)
      item.valid?
      expect(item.errors[:category_id]).to include("を入力してください")
    end

    # 6. prefecture_idが空では登録できないこと
    it "is invalid without a prefecture_id" do
      user = create(:user)
      item = build(:item, prefecture_id: nil, buyer_id: user.id)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    # 7. shipping_day_idが空では登録できないこと
    it "is invalid without a shipping_day_id" do
      user = create(:user)
      item = build(:item, shipping_day_id: nil, buyer_id: user.id)
      item.valid?
      expect(item.errors[:shipping_day_id]).to include("を入力してください")
    end

    # 8. priceが半角数字でなければ登録できないこと
    it "is invalid with a price that has only Half_size number" do
      user = create(:user)
      item = build(:item, price: "あああ", buyer_id: user.id)
      item.valid?
      expect(item.errors[:price]).to include("半角数字で入力してください")
    end
  end
end