class Address < ApplicationRecord
  # Association
  belongs_to :solditems

  # Validation
  with_options presence: true do
    validates :post_number
    validates :prefecture_id
    validates :city
    validates :addresses
    validates :phone_number
  end

  # 郵便番号 3ケタ-4ケタ
  validates :post_number, format { with: /\A\d{3}[-]\d{4}\z/ }

  # 電話番号 半角数字10or11桁
  validates :phone_number, format { with: /\A\d{10,11}\z/ }
end
