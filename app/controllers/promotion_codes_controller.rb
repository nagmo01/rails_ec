# frozen_string_literal: true

class PromotionCodesController < ApplicationController
  def create
    unless PromotionCode.exists?(code: params[:code])
      flash[:failure] = '無効なコードです'
      redirect_to cart_path
      return
    end

    @promotion_code = PromotionCode.find_by(code: params[:code])
    if @promotion_code.payment_id
      flash[:failure] = 'そのコードはすでに使用されています'
    else
      session[:code] = params[:code]
      flash[:successful] = '割引を適用しました'
    end
    redirect_to cart_path
  end
end
