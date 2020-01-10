require 'rails_helper'
describe Image do
  describe '#create' do
    # 2. imageが空では登録できないこと
    it "is invalid without a image" do
      image = build(:image, src: "")
      image.valid?
      expect(image.errors[:src]).to include("を入力してください")
    end
  end
end