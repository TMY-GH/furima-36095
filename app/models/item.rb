class Item < ApplicationRecord
  # Association
  has_one_attached :image
  belongs_to :user
end
