# データベース設計

## Usersテーブル
| Column             | Type     | Option                   |
| -------------------|----------|--------------------------|
| email              | string   | null: false              |
| encrypted_password | string   | null: false              |
| nickname           | string   | null: false              |
| last_name          | string   | null: false              |
| first_name         | string   | null: false              |
| last_name_kana     | string   | null: false              |
| first_name_kana    | string   | null: false              |
| birth_date         | integer  | null: false              |

### Association

- has_many :items
- has_one :addresses

## Itemsテーブル
| Column             | Type        | Option                   |
| -------------------|-------------|--------------------------|
| image              | string      | null: false              |
| name               | string      | null: false              |
| info               | text        | null: false              |
| category_id        | integer     | null: false              |
| status_id          | integer     | null: false              |
| shipping_fee_id    | integer     | null: false              |
| prefecture_id      | integer     | null: false              |
| delivery_days_id   | integer     | null: false              |
| price              | integer     | null: false              |
| user               | references  | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :address

## Addressesテーブル
| Column             | Type        | Option                   |
| -------------------|-------------|--------------------------|
| post_number        | integer     | null: false              |
| prefecture_id      | integer     | null: false              |
| city               | string      | null: false              |
| addresses          | string      | null: false              |
| building           | string      |                          |
| phone_number       | integer     | null: false              |
| user               | references  | null: false, foreign_key: true |
| item               | references  | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
