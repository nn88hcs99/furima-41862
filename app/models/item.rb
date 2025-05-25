class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_condition
  belongs_to :shipping_fee_payer
  belongs_to :prefecture
  belongs_to :shipping_day

  belongs_to :user
  has_one_attached :image
  # has_one :order

  validates :item_title, presence: true, length: { maximum: 40 } # 40文字制限
  validates :item_description, presence: true, length: { maximum: 1000 } # 1000文字制限

  validates :sales_price, presence: true,
                          numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :category_id, :item_condition_id, :shipping_fee_payer_id, :prefecture_id, :shipping_day_id,
            numericality: { other_than: 0, message: "can't be blank" }
  validates :image, presence: true


end
