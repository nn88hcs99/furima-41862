class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :authorize_user!

  def index
    @order_address_form = OrderAddressForm.new
  end

  def create
    @order_address_form = OrderAddressForm.new(order_params)
    if @order_address_form.valid?
      @order_address_form.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def authorize_user!
    redirect_to root_path if @item.user == current_user || @item.order.present?
  end

  def order_params
    params.require(:order_address_form).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :token)
          .merge(user_id: current_user.id, item_id: @item.id)
  end
end
