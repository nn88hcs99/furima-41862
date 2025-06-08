require 'rails_helper'

RSpec.describe OrderAddressForm, type: :model do
  before do
    ActiveRecord::Base.connection.disconnect! 
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address_form = FactoryBot.build(:order_address_form, user_id: user.id, item_id: item.id)
  end

  describe '購入情報の保存' do
    context '購入が成功する場合' do
      it '全ての情報が正しく入力されていれば保存できる' do
        expect(@order_address_form).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_address_form.building_name = ''
        expect(@order_address_form).to be_valid
      end
    end

    context '購入が失敗する場合' do
      it 'postal_codeが空だと保存できないこと' do
        @order_address_form.postal_code = ''
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_address_form.postal_code = '1234567'
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'prefectureを選択していないと保存できないこと' do
        @order_address_form.prefecture_id = 0
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空だと保存できないこと' do
        @order_address_form.city = ''
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include("City can't be blank")
      end

      it 'House numberが空だと保存できないこと' do
        @order_address_form.house_number = ''
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include("House number can't be blank")
      end

      it 'Phone numberが空だと保存できないこと' do
        @order_address_form.phone_number = ''
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'Phone numberが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_address_form.postal_code = '1234567'
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'Phone numberが10文字未満だと保存できない' do
        @order_address_form.phone_number = '123456789'
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include('Phone number is invalid')
      end

      it 'Phone numberが12文字以上だと保存できない' do
        @order_address_form.phone_number = '123456789012'
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include('Phone number is invalid')
      end

      it 'Phone numberに半角数字以外が含まれていると保存できない' do
        @order_address_form.phone_number = '０１２３４５６７８９０'
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include('Phone number is invalid')
      end

      it 'userが紐付いていないと保存できないこと' do
        @order_address_form.user_id = nil
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @order_address_form.item_id = nil
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include("Item can't be blank")
      end

      it 'トークンが空だと保存できない' do
        @order_address_form.token = ''
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include("Token can't be blank")
      end


    end
  end
end