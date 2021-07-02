class SolditemAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id,
                :post_number, :prefecture_id, :city, :addresses, :building, :phone_number, :solditem_id,
                :token

  # Validation
  with_options presence: true do
    validates :user_id
    validates :item_id

    validates :post_number
    validates :prefecture_id
    validates :city
    validates :addresses
    validates :phone_number

    validates :token
  end
  # 都道府県は0を選べない
  validates :prefecture_id, numericality: { other_than: 0 }
  # 郵便番号 3ケタ-4ケタ
  validates :post_number, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  # 電話番号 半角数字10or11桁
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' }

  # saveメソッド
  def save
    solditem = Solditem.create(user_id: user_id, item_id: item_id)
    Address.create(post_number: post_number, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building,
                   phone_number: phone_number, solditem_id: solditem.id)
  end
end
