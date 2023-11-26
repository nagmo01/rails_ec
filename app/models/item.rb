class Item < ApplicationRecord
  has_one_attached :image


  def thumnail
    image.variant(resize_to_limit: [450, 300])
  end

  def large
    image.variant(resize_to_limit: [600, 700])
  end
end
