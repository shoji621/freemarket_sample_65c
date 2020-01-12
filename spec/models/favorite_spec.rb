require 'rails_helper'
describe Favorite do
  describe '#create' do
    # 1. user_idが空では登録できないこと
    it "is invalid without a user_id" do
      favorite = build(:favorite, user_id: "")
      favorite.valid?
      expect(favorite.errors[:user]).to include("を入力してください")
    end
    # 2. item_idが空では登録できないこと
    it "is invalid without a item_id" do
      favorite = build(:favorite, item_id: "")
      favorite.valid?
      expect(favorite.errors[:item]).to include("を入力してください")
    end
  end
end