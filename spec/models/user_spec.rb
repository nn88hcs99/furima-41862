require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき'do
      it 'nickname、email、passwordとpassword_confirmation、family_name、last_name、kana_family_name、kana_last_name、birth_date が存在すれば登録できる' do 
        expect(@user).to be_valid
      end
    end 

    context '新規登録できないとき'do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end

      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name can't be blank"
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end

      it 'kana_family_nameが空では登録できない' do
        @user.kana_family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Kana family name can't be blank"
      end

      it 'kana_last_nameが空では登録できない' do
        @user.kana_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Kana last name can't be blank"
      end

      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birth date can't be blank"
      end
   
      it 'family_nameが半角では登録できない' do
        @user.family_name = 'Yamada' 
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name  is invalid. Input full-width characters"
      end
      it 'last_nameが半角では登録できない' do
        @user.last_name = 'Tarou' 
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name  is invalid. Input full-width characters"
      end

      it 'kana_family_nameがひらがなでは登録できない' do
        @user.kana_family_name = 'やまだ' 
        @user.valid?
        expect(@user.errors.full_messages).to include "Kana family name  is invalid. Input full-width katakana characters"
      end
      it 'kana_last_nameがひらがなでは登録できない' do
        @user.kana_last_name = 'たろう' 
        @user.valid?
        expect(@user.errors.full_messages).to include "Kana last name  is invalid. Input full-width katakana characters"
      end
      it 'kana_family_nameが半角カタカナでは登録できない' do
        @user.kana_family_name = 'ﾔﾏﾀﾞ' 
        @user.valid?
        expect(@user.errors.full_messages).to include "Kana family name  is invalid. Input full-width katakana characters"
      end
      it 'kana_last_nameが半角カタカナでは登録できない' do
        @user.kana_last_name = 'ﾀﾛｳ' 
        @user.valid?
        expect(@user.errors.full_messages).to include "Kana last name  is invalid. Input full-width katakana characters"
      end
    
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = "password123"
        @user.password_confirmation = "password456"
        @user.valid?
        expect(@user.errors.full_messages).to include"Password confirmation doesn't match Password"
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include"Email has already been taken"
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = "testmail"
        @user.valid?
        expect(@user.errors.full_messages).to include"Email is invalid"
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = "1234a"
        @user.password_confirmation = "1234a"
        @user.valid?
        expect(@user.errors.full_messages).to include"Password is too short (minimum is 6 characters)"   
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include"Password is too long (maximum is 128 characters)"
      end
    end 
  end
end