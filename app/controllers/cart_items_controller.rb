# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :set_session

  def index
    @total_price = 0
    @cart.cart_items.each do |cart_item|
      @total_price += cart_item.item.price * cart_item.quantity
    end
    if session[:code]
      @promotion_code = PromotionCode.find_by(code: session[:code])
      @total_price -= @promotion_code.discount_amount
    end
    @payment = Payment.new
  end

  def create
    quantity = if params[:quantity]
                 params[:quantity].to_i
               else
                 1
               end

    if (@cart_item = @cart.cart_items.where(item_id: params[:id]).first)
      @cart_item.quantity += quantity
    else
      @cart_item = @cart.cart_items.build(item_id: params[:id], quantity:)
    end

    if @cart_item.save
      flash[:success] = 'カートに追加しました。'
      redirect_to root_path
    else
      flash[:danger] = 'カートの追加に失敗しました。もう一度試してください。'
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @cart_item = CartItem.find_by(id: params[:id])
    @cart_item.destroy
    redirect_to cart_path
  end

  private

  def set_session
    unless session[:cart_id]
      @cart = Cart.new
      @cart.save
      session[:cart_id] = @cart.id
    end
    @cart = Cart.find_by(id: session[:cart_id])
  end
end
