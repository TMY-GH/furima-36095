require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '登録成功' do
      it 'ニックネーム、メールアドレス、パスワード、パスワード確認、お名前、お名前カナ、生年月日の値がある場合' do
        @user.valid?
        expect(@user).to be_valid
      end
    end
    context '登録失敗' do
      it 'ニックネームが空' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが既に使われている' do
        @another_user = FactoryBot.create(:user)
        @user.email = @another_user.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end
      it 'パスワードが空' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが５文字以下' do 
        @user.password = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'パスワードが半角英数字混合ではない' do
        password = "123456"
        @user.password = password
        @user.password_confirmation = password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'パスワードとパスワード確認が一致しない' do
        @user.password = "1234abcd"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '姓が空' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '姓が全角（漢字・ひらがな・カタカナ）ではない' do
        @user.last_name = "Yamada"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
      end
      it '名が空' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '名が全角（漢字・ひらがな・カタカナ）ではない' do
        @user.first_name = "Tarou"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end
      it '姓（カナ）が空' do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it '姓（カナ）が全角（カタカナ）ではない' do
        @user.last_name_kana = "Yamada"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
      it '名（カナ）が空' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it '名（カナ）が全角（カタカナ）ではない' do
        @user.first_name_kana = "Tarou"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end
      it '生年月日が空' do
        @user.birth_date = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
