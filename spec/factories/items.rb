FactoryBot.define do
  factory :item do
    item_title { Faker::Commerce.product_name }
    item_description { Faker::Lorem.sentence }
    sales_price { rand(300..9_999_999) }
    category_id { rand(1..11) }
    item_condition_id { rand(1..7) }
    shipping_fee_payer_id { rand(1..3) }
    prefecture_id { rand(1..48) }
    shipping_day_id { rand(1..4) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
