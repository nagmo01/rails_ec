class CartController < ApplicationController
  def index
  end

  def show
  end
  
  def create
    unless session[:sha]
      session[:sha] = SecureRandom.hex(10)
    end

    @cart = Cart.new
    @cart.sha = session[:sha]
    @cart.item_id = params[:id]
    @cart.quantity = 1

    if @cart.save
      flash[:success] = 'カートに追加しました。'
      redirect_to '/'
    else
      flash[:danger] = 'カートの追加に失敗しました。もう一度試してください。'
      render 'index', status: :unprocessable_entity
    end

  end

  def destroy
  end


end
