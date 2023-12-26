## usersテーブル

| Column             | Type       | Options                   |
| ------------------ | ---------- | ------------------------- |
| nickname           | string     | null: false               |
| email              | string     | null: false, unique: true |
| encrypted_password | string     | null: false               |
| first_name         | string     | null: false               |
| first_name_ruby    | string     | null: false               |
| last_name          | string     | null: false               |
| last_name_ruby     | string     | null: false               |
| birthday           | date       | null: false               |

  has_many :items
  has_many :payments

## itemsテーブル
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| item_name           | string     | null: false                    |
| description_of_item | text       | null: false                    |
| category_id         | integer    | null: false                    |
| condition_id        | integer    | null: false                    |
| postage_id          | integer    | null: false                    |
| item_address_id     | integer    | null: false                    |
| prefecture_id       | integer    | null: false                    |
| price               | integer    | null: false                    |
| user                | reference  | null: false, foreign_key: true |

  has_one :payment
  belongs_to :user

## paymentテーブル
| Column | Type       | Options                       |
| ------ | ---------- | ----------------------------- |
| user   | references |null: false, foreign_key: true |
| item   | references |null: false, foreign_key: true |

  belongs_to :user
  belongs_to :item
  has_one :address

## addressテーブル
| Column           | Type       | Options                       |
| ---------------- | ---------- | ----------------------------- |
| post_code        | string     | null: false                   |
| prefecture_id    | integer    | null: false                   |
| municipality     | string     | null: false                   |
| street_address   | string     | null: false                   |
| building_name    | string     |                               |
| telephone_number | string     | null: false                   |
| payment          | references |null: false, foreign_key: true |

  belongs_to :payment


