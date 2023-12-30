# frozen_string_literal: true

class CheckoutMailer < ApplicationMailer
  def complete(payment)
    @total_price = 0
    payment.purchased_items.each do |item|
      @total_price += item.price * item.quantity
    end
    @payment = payment
    if Rails.env.development?
      @url = 'http://localhost:3000'
    elsif Rails.env.production?
      @url = 'https://hc-rails-ec-ffe7dfe15b3c.herokuapp.com'
    end
    mail(
      to: payment.email,
      subject: '決済完了のお知らせ'
    )
  end
end
