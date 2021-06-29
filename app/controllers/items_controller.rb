class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
  end

  private
  def item_params
    params.require(:item).permit(:name, :info, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :delivery_days_id, :price).merge(user_id: current_user.id)
  end
end
