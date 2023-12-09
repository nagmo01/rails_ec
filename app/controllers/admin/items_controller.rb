# frozen_string_literal: true

module Admin
  class ItemsController < ApplicationController
    before_action :basic_auth
    def index
      @items = Item.all.order(created_at: :asc)
    end

    def new
      @item = Item.new
    end

    def create
      @item = Item.new(item_params)
      unless @item.image.attached?
        @item.image.attach(io: File.open(Rails.root.join('app/assets/images/cart.jpg')), filename: 'cart.jpg')
      end

      if @item.save
        flash[:success] = '商品を登録しました。'
        redirect_to admin_items_path
      else
        flash[:danger] = '商品の登録に失敗しました。もう一度試してください。'
        render 'new', status: :unprocessable_entity
      end
    end

    def edit
      @item = Item.find(params[:id])
      return unless @item.nil?

      flash[:danger] = '商品が見つかりませんでした。'
      redirect_to '/admin'
    end

    def update
      @item = Item.find(params[:id])

      if @item.update(item_params)
        flash[:success] = '商品を更新しました。'
        redirect_to admin_items_path
      else
        flash[:danger] = '商品の更新に失敗しました。もう一度試してください。'
        render :edit
      end
    end

    def destroy
      @item = Item.find(params[:id])
      @item.destroy
      flash[:success] = '投稿が削除されました。'
      redirect_to admin_items_path, status: :see_other
    end

    private

    def item_params
      params.require(:item).permit(:name, :price, :sku, :description, :image)
    end

    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
      end
    end
  end
end
