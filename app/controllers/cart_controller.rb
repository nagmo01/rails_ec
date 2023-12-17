class CartController < ApplicationController
  before_action :set_session

  def index
  end

  def show
    @carts = Cart.where(sha: session[:sha])
    @total_price = 0
    @carts.each do |cart|
      @total_price += cart.item.price * cart.quantity
    end

  end

  def create

    if params[:quantity]
      quantity = params[:quantity].to_i
    else
      quantity = 1
    end

    if @cart = Cart.where(sha: session[:sha], item_id: params[:id]).first
      @cart.quantity += quantity
    else
      @cart = Cart.new
      @cart.sha = session[:sha]
      @cart.item_id = params[:id]
      @cart.quantity = quantity
    end


    if @cart.save
      flash[:success] = 'カートに追加しました。'
      redirect_to '/'
    else
      flash[:danger] = 'カートの追加に失敗しました。もう一度試してください。'
      render 'index', status: :unprocessable_entity
    end

  end

  def destroy
    @carts = Cart.where(sha: session[:sha])
    @cart = @carts.find_by(id: params[:id])
    @cart.destroy
    redirect_to "/cart"
    
  end


  private

  def set_session
    session[:sha] = SecureRandom.hex(10) unless session[:sha]
  end

end
