class CartController < ApplicationController
  before_action :set_session

  def index
  end

  def show
    @cart = Cart.find_by(sha: session[:sha])
  end

  def create

    if @cart = Cart.where(sha: session[:sha], item_id: params[:id]).first
      @cart.quantity += 1
    else
      @cart = Cart.new
      @cart.sha = session[:sha]
      @cart.item_id = params[:id]
      @cart.quantity = 1
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
  end


  private

  def set_session
    session[:sha] = SecureRandom.hex(10) unless session[:sha]
  end

end
