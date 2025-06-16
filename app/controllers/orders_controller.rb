class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :authorize_user!

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address_form = OrderAddressForm.new
  end

  def create
    @order_address_form = OrderAddressForm.new(order_params)
    if @order_address_form.valid?
      pay_item
      @order_address_form.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
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
    params.require(:order_address_form).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number)
          .merge(user_id: current_user.id, item_id: @item.id, amount: @item.sales_price, token: params[:token]) # ← token を params から直接追加
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: order_params[:amount],
      card: order_params[:token],
      currency: 'jpy' 
    )
  end
end
