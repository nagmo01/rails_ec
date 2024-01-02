# frozen_string_literal: true

class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  validates :name, presence: true
  has_one_attached :image
end
