# frozen_string_literal: true

class PaymentsController < ApplicationController
  def create
    @payment = Payment.new(payment_params)
    @cart = Cart.find_by(id: session[:cart_id])

    if @payment.save
      ActiveRecord::Base.transaction do
        create_purchased_items
        CheckoutMailer.complete(@payment).deliver
        clear_cart
        flash[:success] = '購入ありがとうございます'
        redirect_to root_path
      end
    else
      flash[:danger] = '購入に失敗しました'
      @total_price = calculate_total_price
      @messages = @payment.errors
      render template: 'cart_items/index', status: :unprocessable_entity
    end

    private

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

    def clear_cart
      session[:cart_id] = nil
      @cart.destroy
    end

    def payment_params
      params.require(:payment).permit(:last_name, :first_name, :user_name, :email, :address, :address2, :pref, :city,
                                      :zip, :cc_name, :cc_number, :cc_expiration, :cc_cvv)
    end
  end
