class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
   # 半角英数字混合
  validates :password, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/i, message: "is invalid. Include both letters and numbers" }
  # 複数のカラムにバリデーション
  with_options presence: true do
    validates :nickname
    validates :birth_date
    # 全角（漢字・ひらがな・カタカナ）
    validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "is invalid. Input full-width characters"} 
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "is invalid. Input full-width characters"}
    # 全角（カタカナ）
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana characters"}
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana characters"}
  end
end