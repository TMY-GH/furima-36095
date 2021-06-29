class Item < ApplicationRecord
  # Association
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensionss
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :delivery_days

  belongs_to :user
end
