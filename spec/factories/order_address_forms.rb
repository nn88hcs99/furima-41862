FactoryBot.define do
  factory :order_address_form do
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '札幌市' }
    house_number { '1-1-1' }
    building_name { 'コーポABC' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }

    # ユーザーと商品を関連付ける
    association :user
    association :item
  end
end
