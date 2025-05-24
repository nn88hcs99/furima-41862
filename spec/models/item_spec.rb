require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)  
    @item = FactoryBot.build(:item, user: @user)  
  end

  describe '商品出品' do
    context '正常系: 商品出品できるとき' do
      it '全ての項目が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '異常系: 商品出品できないとき' do
      it '商品名が空では出品できない' do
        @item.item_title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item title can't be blank")
      end

      it '商品説明が空では出品できない' do
        @item.item_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item description can't be blank")
      end

      it '販売価格が空では出品できない' do
        @item.sales_price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales price can't be blank")
      end

      it '販売価格が300未満では出品できない' do
        @item.sales_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales price must be greater than or equal to 300")
      end

      it '販売価格が9,999,999を超えると出品できない' do
        @item.sales_price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales price must be less than or equal to 9999999")
      end

      it '販売価格が整数でない場合は出品できない' do
        @item.sales_price = 300.5
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales price must be an integer")
      end

      it '販売価格が半角数値以外の場合は出品できない' do
        @item.sales_price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales price is not a number")
      end
      
      it '画像が添付されていないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      
      it 'カテゴリーが未選択（id: 0）では出品できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態が未選択 (id: 0) では出品できない' do
        @item.item_condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Item condition can't be blank")
      end

      it '配送料の負担が未選択 (id: 0) だと出品できない' do
        @item.shipping_fee_payer_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee payer can't be blank")
      end

      it '発送元の地域が未選択 (id: 0) だと出品できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数が未選択 (id: 0) だと出品できない' do
        @item.shipping_day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end
    end
  end
end