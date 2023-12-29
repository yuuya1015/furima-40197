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
      it 'パスワードは半角数字のみの場合登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        expect(@user).not_to be_valid
      end
      it 'パスワードは半角英字のみの場合登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        expect(@user).not_to be_valid
      end
      it 'パスワードは半角英数字以外の文字が含まれている場合登録できない' do
        @user.password = '12345&'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it '名前(全角)は、名字と名前がそれぞれ入力されていないと登録できない' do
        @user.last_name = ''
        @user.first_name = ''
        expect(@user).not_to be_valid
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "First name can't be blank")
      end
      it 'last_nameがひらがな、カタカナ、漢字以外が含まれている場合登録できない' do
        @user.last_name = '田中&メアリー'
        expect(@user).not_to be_valid
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name ひらがな、カタカナ、漢字以外が含まれている場合登録できない')
      end
      it 'first_nameひらがな、カタカナ、漢字以外が含まれている場合登録できない' do
      @user.first_name = '田中&メアリー'
      expect(@user).not_to be_valid
      @user.valid?
      expect(@user.errors.full_messages).to include('First name ひらがな、カタカナ、漢字以外が含まれている場合登録できない')
      end
      it 'first_name_ruby全角カタカナ以外が含まれている場合登録できない' do
        @user.first_name_ruby = 'meありー'
        expect(@user).not_to be_valid
        @user.valid?
        expect(@user.errors.full_messages).to include('First name ruby 名字(カナ)・名前(カナ)は全角カタカナを使用してください')
      end
      it 'last_name_ruby全角カタカナ以外が含まれている場合登録できない' do
        @user.last_name_ruby = 'meありー'
        expect(@user).not_to be_valid
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name ruby 名字(カナ)・名前(カナ)は全角カタカナを使用してください')
      end
      it 'first_name_ruby空の場合登録できない' do
        @user.first_name_ruby = ''
        expect(@user).not_to be_valid
        @user.valid?
        expect(@user.errors.full_messages).to include("First name ruby can't be blank")
      end
      it 'last_name_ruby空の場合登録できない' do
        @user.last_name_ruby = ''
        expect(@user).not_to be_valid
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name ruby can't be blank")
      end
      it '生年月日が入力されていないと登録できない' do
        @user.birthday = 'nil'
        expect(@user).not_to be_valid
      end
    end
    context '正常なユーザー登録' do
      it 'バリデーションの正常系' do
        expect(@user.valid?).to be true
      end
    end
  end
end