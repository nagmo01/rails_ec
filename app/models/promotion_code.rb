# frozen_string_literal: true

class PromotionCode < ApplicationRecord
  belongs_to :payment, optional: true
end
