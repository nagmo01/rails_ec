class PromotionCode < ApplicationRecord
  belongs_to :payment, optional: true
end
