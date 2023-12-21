# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :set_session
  before_action :get_cart

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
      redirect_to '/'
    else
      flash[:danger] = 'カートの追加に失敗しました。もう一度試してください。'
      render 'index', status: :unprocessable_entity
    end
  end

  def destroy
    @cart_item = CartItem.find_by(id: params[:id])
    @cart_item.destroy
    redirect_to '/cart'
  end

  private

  def set_session
    unless session[:session_id]
      session[:session_id] = SecureRandom.hex(10)
    end
  end

  def get_cart
    @cart = Cart.find_by(session_id: session[:session_id])
    unless @cart
      @cart = Cart.new
      @cart.session_id = session[:session_id]
      @cart.save
    end
  end


end
