# frozen_string_literal: true

class PaymentsController < ApplicationController
  def create
    @payment = Payment.new(payment_params)
    @cart = Cart.find_by(id: session[:cart_id])
    @promotion_code = PromotionCode.find_by(code: session[:code]) if session[:code]

    begin
      ActiveRecord::Base.transaction do
        if @payment.save
          create_purchased_items
          apply_promotion_code
          CheckoutMailer.complete(@payment).deliver
          clear_session
          flash[:success] = '購入ありがとうございます'
          redirect_to root_path
        else
          flash[:danger] = '購入に失敗しました'
          discount = @promotion_code ? @promotion_code.discount_amount : 0
          @total_price = calculate_total_price - discount
          @messages = @payment.errors
          render template: 'cart_items/index', status: :unprocessable_entity
        end
      end
    rescue StandardError
      clear_session
      flash[:danger] = '購入処理に失敗しました、最初からやり直してください。'
      redirect_to root_path
    end
  end

  private

  def apply_promotion_code
    return unless @promotion_code

    @promotion_code.payment_id = @payment.id
    @promotion_code.save!
  end

  def create_purchased_items
    @cart.cart_items.each do |cart_item|
      @purchased_item = PurchasedItem.new(
        payment_id: @payment.id,
        name: cart_item.item.name,
        price: cart_item.item.price,
        description: cart_item.item.description,
        quantity: cart_item.quantity
      )
      @purchased_item.save!
    end
  end

  def calculate_total_price
    total_price = 0
    @cart.cart_items.each do |cart_item|
      total_price += cart_item.item.price * cart_item.quantity
    end
    total_price
  end

  def clear_session
    session[:code] = nil
    session[:cart_id] = nil
    @cart.destroy
  end

  def payment_params
    params.require(:payment).permit(:last_name, :first_name, :user_name, :email, :address, :address2, :pref, :city,
                                    :zip, :cc_name, :cc_number, :cc_expiration, :cc_cvv)
  end
end
