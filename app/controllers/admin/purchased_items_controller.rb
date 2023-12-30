module Admin
  class PurchasedItemsController < ApplicationController
    before_action :basic_auth
    def index
      @payments = Payment.all

    end

    def show
      @payment = Payment.find_by(id: params[:id])
      @total_price = 0
      @payment.purchased_items.each do |purchased_item|
        @total_price += purchased_item.price * purchased_item.quantity
      end
    end

    private

    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['BASIC_AUTH_CHECKOUT_USER'] && password == ENV['BASIC_AUTH_CHECKOUT_PASSWORD']
      end
    end


  end
end
