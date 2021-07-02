class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :access_rule, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :new
    end
  end

  def destroy
    @item.destroy
    redirect_to action: :index
  end

  private

  def item_params
    params
      .require(:item)
      .permit(:image, :name, :info, :category_id, :status_id, :shipping_fee_id,
              :prefecture_id, :delivery_days_id, :price)
      .merge(user_id: current_user.id)
  end

  def access_rule
    # 本人以外の編集||売却済み商品
    redirect_to root_path if @item.user != current_user || @item.solditem
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
