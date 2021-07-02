require 'rails_helper'

RSpec.describe SolditemAddress, type: :model do
  describe  '商品の購入' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      # sia = solditem_adressの略
      @sia = FactoryBot.build(:solditem_address, user_id: user.id, item_id: item.id, solditem_id: item.id)
      # MySQLの処理不可防止
      sleep 0.03
    end
    context '商品を購入できる' do
      it '全てのフォームに正しい情報が入っている' do
        @sia.valid?
        expect(@sia).to be_valid
      end
      it '建物名が空' do
        @sia.building = nil
        expect(@sia).to be_valid
      end
    end
    context '商品を購入できない' do
      it 'クレジットカードの情報が正しくない' do
        @sia.token = nil
        @sia.valid?
        expect(@sia.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空' do
        @sia.post_number = nil
        @sia.valid?
        expect(@sia.errors.full_messages).to include("Post number can't be blank")
      end
      it '郵便番号にハイフンがない' do
        @sia.post_number = '1234567'
        @sia.valid?
        expect(@sia.errors.full_messages).to include("Post number is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '郵便番号が全角数字' do
        @sia.post_number = "１２３-４５６７"
        @sia.valid?
        expect(@sia.errors.full_messages).to include("Post number is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '郵便番号の始めが３桁ではない' do
        @sia.post_number = '12-3456'
        @sia.valid?
        expect(@sia.errors.full_messages).to include("Post number is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '郵便番号の終わりが４桁ではない' do
        @sia.post_number = '123-456'
        @sia.valid?
        expect(@sia.errors.full_messages).to include("Post number is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '都道府県が空' do
        @sia.prefecture_id = nil
        @sia.valid?
        expect(@sia.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県で「--」を選んでいる' do
        @sia.prefecture_id = 0
        @sia.valid?
        expect(@sia.errors.full_messages).to include("Prefecture must be other than 0")
      end
      it '市区町村が空' do
        @sia.city = nil
        @sia.valid?
        expect(@sia.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空' do
        @sia.addresses = nil
        @sia.valid?
        expect(@sia.errors.full_messages).to include("Addresses can't be blank")
      end
      it '電話番号が空' do
        @sia.phone_number = nil
        @sia.valid?
        expect(@sia.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が10か11桁じゃない' do
        @sia.phone_number = "123456789"
        @sia.valid?
        expect(@sia.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it '電話番号が全角数字' do
        @sia.phone_number = "１２３４５６７８９０"
        @sia.valid?
        expect(@sia.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it '電話番号にハイフンが入っている' do
        @sia.phone_number = "12-3456-7890"
        @sia.valid?
        expect(@sia.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
    end
  end
end
