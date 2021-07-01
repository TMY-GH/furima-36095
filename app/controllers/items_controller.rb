class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @items = Item.all.order('created_at DESC')
  end

  def show
    @item = Item.find(params[:id])
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
    @item = Item.find(params[:id])
    @image = @item.image
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to root_path
    else
      render :new 
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :info, :category_id, :status_id, :shipping_fee_id, :prefecture_id,
                                 :delivery_days_id, :price).merge(user_id: current_user.id)
  end
end
