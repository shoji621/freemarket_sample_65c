require 'rails_helper'
describe Address do
  describe '#create' do

    # 1. zipcode, prefecture_id, city, blockが存在すれば登録できること
    it "is valid with a user, zipcode, prefecture_id, city, block" do
      address = build(:address)
      expect(address).to be_valid
    end
    # 2. zipcodeが空では登録できないこと
    it "is invalid without a zipcode" do
      address = build(:address, zipcode: "")
      address.valid?
      expect(address.errors[:zipcode]).to include("を入力してください")
    end
    # 3. prefecture_idが空では登録できないこと
    it "is invalid without a prefecture_id" do
      address = build(:address, prefecture_id: "")
      address.valid?
      expect(address.errors[:prefecture_id]).to include("を入力してください")
    end
    # 4. cityが空では登録できないこと
    it "is invalid without a city" do
      address = build(:address, city: "")
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end
    # 5. blockが空では登録できないこと
    it "is invalid without a block" do
      address = build(:address, block: "")
      address.valid?
      expect(address.errors[:block]).to include("を入力してください")
    end
    # 6. zipcodeが郵便番号形式でなければ登録できないこと
    it "is invalid with a zipcode format (XXX-XXXX)" do
      address = build(:address, zipcode: "1234567")
      address.valid?
      expect(address.errors[:zipcode]).to include("はハイフン入り７桁で入力してください")
    end
    # 7. zipcodeが郵便番号形式であれば登録できること
    it "is valid with a zipcode format (XXX-XXXX)" do
      address = build(:address, zipcode: "123-4567")
      expect(address).to be_valid
    end
  end
end