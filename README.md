# README

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------  | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| family_name        | string  | null: false               |
| last_name          | string  | null: false               |
| kana_family_name   | string  | null: false               |
| kana_last_name     | string  | null: false               |
| birth_date         | date    | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column                 | Type        | Options                        |
| ---------------------  | ----------  | ------------------------------ |
| item_title             | string      | null: false                    |
| item_description       | text        | null: false                    |
| category_id            | integer     | null: false                    |
| item_condition_id      | integer     | null: false                    |
| shipping_fee_payer_id  | integer     | null: false                    |
| prefecture_id          | integer     | null: false                    |
| shipping_day_id        | integer     | null: false                    |
| sales_price            | integer     | null: false                    |
| user                   | references  | null: false, foreign_key: true |

### Association

- belongs_to :user  # 出品者
- has_one :order    # 1商品につき1つの注文

- belongs_to_active_hash :category
- belongs_to_active_hash :item_condition
- belongs_to_active_hash :shipping_fee_payer
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :shipping_day

## orders テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item               | references | null: false, foreign_key: true | 
| user               | references | null: false, foreign_key: true | 

### Association  
- belongs_to :item  # 購入した商品  
- belongs_to :user  # 購入者  
- has_one :shipping_address


## shipping_address テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| order            | references | null: false, foreign_key: true | 
| postal_code      | string     | null: false                    |
| prefecture_id    | integer    | null: false                    | 
| city             | string     | null: false                    |  
| house_number     | string     | null: false                    |  
| building_name    | string     |                                |  
| phone_number     | string     | null: false                    |  

### Association  
- belongs_to :order 

- belongs_to_active_hash :prefecture