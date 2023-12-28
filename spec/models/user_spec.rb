require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー新規登録ができない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emailが空では登録できない/ユーザー情報' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'メールアドレスが一意性でなければ登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは、@が含まれていなければ登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'パスワードは、6文字以上の入力がされない場合は登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードとパスワード（確認）は、値の一致していなければ登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '名前(全角)は、名字と名前がそれぞれ入力されていないと登録できない' do
        @user.last_name = ''
        @user.first_name = ''
        expect(@user).not_to be_valid
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "First name can't be blank")
      end
      it '名字と名前は、全角（漢字・ひらがな・カタカナ）それぞれ入力されていないと登録できない' do
        user = User.new(last_name: '山田1太郎ひらがなカタカナ漢字ー')
        expect(user).not_to be_valid
        @user.valid?
        expect(user.errors.full_messages).to include('Last name 全角文字を使用してください', 'First name 全角文字を使用してください')
      end
      it '生年月日が入力されていないと登録できない' do
        user = User.new(birthday: nil)
        expect(user).not_to be_valid
      end
      context 'ユーザー登録ができる場合' do
        it 'nicknameとemail、passwordとpassword_confirmation、first_nameとfirst_name_ruby、last_nameとlast_name_ruby、生年月日が存在すれば登録できる' do
          expect(@user).to be_valid
        end
      end
    end
  end
end
