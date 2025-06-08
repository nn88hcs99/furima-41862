class OrderAddressForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :token

with_options presence: true do
  validates :user_id
  validates :item_id
  validates :postal_code
  validates :prefecture_id
  validates :city
  validates :house_number
  validates :phone_number
  #validates :token
end
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}

  def save
    #return false unless valid?  # ← バリデーションチェックを追加！

    order = Order.create(user_id: user_id, item_id: item_id)

    ShippingAddress.create(order_id: order.id, postal_code: postal_code, prefecture: prefecture, city: city, 
                           house_number: house_number, building_name: building_name, phone_number: phone_number)
  end
end

  
  
