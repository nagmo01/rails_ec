# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :set_session
  before_action :cart

  def index
    @total_price = 0
    @cart.cart_items.each do |cart_item|
      @total_price += cart_item.item.price * cart_item.quantity
    end
  end

  def create
    quantity = if params[:quantity]
                 params[:quantity].to_i
               else
                 1
               end

    if (@cart_item = CartItem.where(cart_id: @cart.id, item_id: params[:id]).first)
      @cart_item.quantity += quantity
    else
      @cart_item = CartItem.new
      @cart_item.cart_id = @cart.id
      @cart_item.item_id = params[:id]
      @cart_item.quantity = quantity
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
    return if session[:cart_id]

    @cart = Cart.new
    @cart.save
    session[:cart_id] = @cart.id
  end

  def cart
    @cart = Cart.find_by(id: session[:cart_id])
  end

end
