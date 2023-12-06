class AdminController < ApplicationController
  
  def index
    @items = Item.all.order(created_at: :asc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      flash[:success] = "商品を登録しました。"
      redirect_to "/admin"
    else
      flash[:danger] = "商品の登録に失敗しました。もう一度試してください。"
      render 'new', status: :unprocessable_entity
    end
  end
  


  def edit
    @item = Item.find(params[:id])
    if @item.nil?
      flash[:danger] = "商品が見つかりませんでした。"
      redirect_to "/admin"
    end
  end

  def update
    @item = Item.find(params[:id])
  
    if @item.update(item_params)
      flash[:success] = "商品を更新しました。"
      redirect_to "/admin"
    else
      flash[:danger] = "商品の更新に失敗しました。もう一度試してください。"
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:success] = "投稿が削除されました。"
    redirect_to "/admin", status: :see_other
  end

private
  
  def item_params
    params.require(:item).permit(:name, :price, :sku, :description, :image)
  end
  
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end


end
