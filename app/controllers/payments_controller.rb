class PaymentsController < ApplicationController
  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      flash[:success] = "購入ありがとうございます"
      redirect_to items_path
    else
      flash[:danger] = "購入に失敗しました"
      @total_price = 0
      @cart.cart_items.each do |cart_item|
        @total_price += cart_item.item.price * cart_item.quantity
      end
      render template: "cart_items/index"
    end
  end




  private
  
  def payment_params
    params.require(:payment).permit(:last_name, :first_name, :user_name, :email, :address, :address2, :country, :state, :zip, :cc_name, :cc_number, :cc_expiration, :cc_cvv)
  end

end
