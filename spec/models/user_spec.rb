require 'rails_helper'
describe User do
  describe '#create' do
    # 1. nickname, email, password, last_name, first_name, last_name_kana, first_name_kana, birthday, phone_authyが存在すれば登録できること
    it "is valid with a nickname, email, password, last_name, first_name, last_name_kana, first_name_kana, birthday, phone_authy" do
      user = build(:user)
      expect(user).to be_valid
    end
    # 2. nicknameが空では登録できないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end
    # 3. emailが空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    # 4. passwordが空では登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
    # 5. last_nameが空では登録できないこと
    it "is invalid without a last_name" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください")
    end
    # 6. first_nameが空では登録できないこと
    it "is invalid without a first_name" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end
    # 7. last_name_kanaが空では登録できないこと
    it "is invalid without a last_name" do
      user = build(:user, last_name_kana: "")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("を入力してください")
    end
    # 8. first_name_kanaが空では登録できないこと
    it "is invalid without a first_name_kana" do
      user = build(:user, first_name_kana: "")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end
    # 9. birthdayが空では登録できないこと
    it "is invalid without a birthday" do
      user = build(:user, birthday: "")
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end
    # 10. phone_authyが空では登録できないこと
    it "is invalid without a phone_authy" do
      user = build(:user, phone_authy: "")
      user.valid?(:validates_phone)
      expect(user.errors[:phone_authy]).to include("を入力してください")
    end
    # 11. 重複したnicknameが存在する場合登録できないこと
    it "is invalid with a duplicate nickname" do
      user = create(:user)
      another_user = build(:user, nickname: user.nickname)
      another_user.valid?
      expect(another_user.errors[:nickname]).to include("はすでに存在します")
    end
    # 13. emailが存在する場合登録できないこと
    it "is invalid with a duplicate email" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end
    # 13. emailがメールアドレス形式でなければ登録できないこと
    it "is invalid with a email format" do
      user = build(:user, email: "a<")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
    # 14. passwordが7文字以上であれば登録できること
    it "is valid with a password that has more than 7 characters" do
      user = build(:user, password: "000aaaa")
      user.valid?
      expect(user).to be_valid
    end
    # 15. passwordが6文字以下であれば登録できないこと
    it "is invalid with a password that has less than 6 characters" do
      user = build(:user, password: "000aaa")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上の半角英数字で入力してください")
    end
    # 16. passwordが数字のみであれば登録できないこと
    it "is invalid with a password that has only number" do
      user = build(:user, password: "000000")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上の半角英数字で入力してください")
    end
    # 17. passwordが英字のみであれば登録できないこと
    it "is invalid with a password that has only English letter" do
      user = build(:user, password: "aaaaaa")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上の半角英数字で入力してください")
    end
    # 18. last_nameが全角のみであれば登録できること
    it "is valid with a last_name that has only Full-width" do
      user = build(:user, last_name: "山田")
      user.valid?
      expect(user).to be_valid
    end
    # 19. last_nameが全角のみでなければ登録できないこと
    it "is invalid with a last_name that doesn't have Full-width" do
      user = build(:user, last_name: "yamada")
      user.valid?
      expect(user.errors[:last_name]).to include("は全角で入力してください")
    end
    # 20. first_nameが全角のみであれば登録できること
    it "is valid with a first_name that has only Full-width" do
      user = build(:user, first_name: "彩")
      user.valid?
      expect(user).to be_valid
    end
    # 21. first_nameが全角のみでなければ登録できないこと
    it "is invalid with a last_name that doesn't have Full-width" do
      user = build(:user, first_name: "aya")
      user.valid?
      expect(user.errors[:first_name]).to include("は全角で入力してください")
    end
    # 22. last_name_kanaが全角カタカナのみであれば登録できること
    it "is valid with a last_name_kana that has only Full-width Katakana" do
      user = build(:user, last_name_kana: "ヤマダ")
      user.valid?
      expect(user).to be_valid
    end
    # 23. last_name_kanaが全角カタカナのみでなければ登録できないこと
    it "is invalid with a last_name_kana that doesn't have Full-width Katakana" do
      user = build(:user, last_name_kana: "山田")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("はカタカナで入力してください")
    end
    # 24. first_name_kanaが全角カタカナのみであれば登録できること
    it "is valid with a first_name_kana that has only Full-width Katakana" do
      user = build(:user, first_name_kana: "アヤ")
      user.valid?
      expect(user).to be_valid
    end
    # 25. first_name_kanaが全角カタカナのみでなければ登録できないこと
    it "is invalid with a last_name_kana that doesn't have Full-width Katakana" do
      user = build(:user, first_name_kana: "彩")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("はカタカナで入力してください")
    end
    # 26. phone_authyが半角数字11桁でなければ登録できないこと
    it "is invalid with a phone_authy that doesn't have 11 digits" do
      user = build(:user, phone_authy: "0")
      user.valid?(:validates_phone)
      expect(user.errors[:phone_authy]).to include("は11桁の半角数字(ハイフンなし)で入力してください")
    end
  end
end