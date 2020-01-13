require 'rails_helper'
describe Comment do
  describe '#create' do
    # 1. textが空では登録できないこと
    it "is invalid without a text" do
      comment = build(:comment, text: "")
      comment.valid?
      expect(comment.errors[:text]).to include("を入力してください")
    end
    # 2. user_idが空では登録できないこと
    it "is invalid without a user_id" do
      comment = build(:comment, user_id: "")
      comment.valid?
      expect(comment.errors[:user]).to include("を入力してください")
    end
    # 3. item_idが空では登録できないこと
    it "is invalid without a item_id" do
      comment = build(:comment, item_id: "")
      comment.valid?
      expect(comment.errors[:item]).to include("を入力してください")
    end
  end
end