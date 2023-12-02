# frozen_string_literal: true

6.times do |i|
  item = Item.create!(name: "商品#{i}", price: rand(1000..10_000), sku: "SKU#{i}", description: "商品#{i}の説明文です。")
  item.image.attach(io: File.open('app/assets/images/cart.jpg'), filename: 'cart.jpg')
end
