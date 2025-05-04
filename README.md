# README

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| user_name          | string | null: false               |
| user_kana_name     | string | null: false               |
| birth_date         | date   | null: false               |


### Association

- has_many :items
- has_many :orders
- has_many :comments


## items テーブル

| Column              | Type        | Options                        |
| ------------------- | ----------  | ------------------------------ |
| item_title          | string      | null: false                    |
| item_description    | text        | null: false                    |
| item_condition      | string      | null: false                    |
| shipping_fee_payer  | string      | null: false                    |
| shipping_from       | string      | null: false                    |
| shipping_method     | string      | null: false                    |
| shipping_days       | string      | null: false                    |
| sales_price         | integer     | null: false                    |
| sales_fee           | integer     | null: false                    |
| sales_profit        | integer     | null: false                    |
| user_id             | references  | null: false, foreign_key: true |
| is_sold             | boolean     | null: false, default: false    |


### Association

- belongs_to :user  # 出品者
- has_one :order    # 1商品につき1つの注文
- has_many :comments


## orders テーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| item_id              | references | null: false, foreign_key: true | 
| user_id              | references | null: false, foreign_key: true | 
| purchase_price       | integer    | null: false                    |
| shipping_postal_code | string     | null: false                    |
| shipping_prefecture  | string     | null: false                    | 
| shipping_city        | string     | null: false                    |  
| shipping_address     | string     | null: false                    |  
| building_name        | string     |                                |  
| phone_number         | string     | null: false                    |  

### Association  
- belongs_to :item  # 購入した商品  
- belongs_to :user  # 購入者  



## comments テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| content  | string     |                                |
| user_id  | references | null: false, foreign_key: true |
| item_id  | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user