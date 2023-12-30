# frozen_string_literal: true

class Item < ApplicationRecord
  has_many :cart_items
  validates :name, presence: true
  has_one_attached :image
end
