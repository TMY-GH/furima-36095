class SolditemsController < ApplicationController
  before_action :set_item, only: [:new, :create]
  before_action :authenticate_user!
  before_action :can_buy, only: [:new, :create]
  def new
    @solditem_address = SolditemAddress.new
  end

  def create
    @solditem_address = SolditemAddress.new(solditem_address_params)
    if @solditem_address.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: @item.price, # 商品の値段
        card: params[:token], # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
      @solditem_address.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def solditem_address_params
    params
      .require(:solditem_address)
      .permit(:post_number, :prefecture_id, :city, :addresses, :building, :phone_number)
      .merge(token: params[:token], user_id: current_user.id, item_id: @item.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def can_buy
    redirect_to root_path if !@item.solditem.nil? || current_user == @item.user
  end
end
