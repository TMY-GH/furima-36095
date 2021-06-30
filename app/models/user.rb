class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Association
  has_many :items

  # 半角英数字混合
  validates :password,
            format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/i, message: 'is invalid. Include both letters and numbers' }

  # 必須項目
  with_options presence: true do
    validates :nickname
    validates :birth_date
    validates :last_name
    validates :first_name
    validates :last_name_kana
    validates :first_name_kana
  end

  # 全角（漢字・ひらがな・カタカナ）
  with_options format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'is invalid. Input full-width characters' } do
    validates :last_name
    validates :first_name
  end

  # 全角（カタカナ）
  with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' } do
    validates :last_name_kana
    validates :first_name_kana
  end
end
