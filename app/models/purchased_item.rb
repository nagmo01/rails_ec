# frozen_string_literal: true

class PurchasedItem < ApplicationRecord
  belongs_to :payment
end
