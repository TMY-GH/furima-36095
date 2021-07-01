class Item < ApplicationRecord
  # Association
  belongs_to :user
  has_one :solditems

  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :delivery_days

  # Validation
  with_options presence: true do
    validates :image
    validates :name
    validates :info
    validates :category_id
    validates :status_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :delivery_days_id
    validates :price
  end
  # ActiveHashはid:1は選択できない
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :shipping_fee_id
    # 都道府県だけid:0からスタート
    validates :prefecture_id, numericality: { other_than: 0 }
    validates :delivery_days_id
  end
  # 価格は¥300~¥9,999,999の間
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than: 1_000_000 }
  # 価格は半角数字
  validates :price, format: { with: /\A[0-9]+\z/ }
end
