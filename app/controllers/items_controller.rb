class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :authorize_user!, only: [:edit, :update]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def show
  end

  def create
    @item = Item.new(create_item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    item.destroy
    redirect_to root_path
  end

  def edit
  end


 def update
  if current_user == @item.user
    if @item.update(update_item_params) 
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  else
    redirect_to root_path
  end
end

private
 def set_item
    @item = Item.find(params[:id])
  end

 def create_item_params
    params.require(:item).permit(:image, :item_title, :item_description, :category_id, :item_condition_id,
                                 :shipping_fee_payer_id, :prefecture_id, :shipping_day_id, :sales_price)
                         .merge(user_id: current_user.id)
 end
 def update_item_params
    params.require(:item).permit(:image, :item_title, :item_description, :category_id, :item_condition_id,
                                 :shipping_fee_payer_id, :prefecture_id, :shipping_day_id, :sales_price)
 end

  def authorize_user!
    #@item = Item.find(params[:id]) # 商品情報を取得
    redirect_to root_path,  unless @item.user == current_user
  end
end
