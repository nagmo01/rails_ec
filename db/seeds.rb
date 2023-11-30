# frozen_string_literal: true

6.times do |i|
  item = Item.create!(name: "商品#{i}", price: rand(1000..10_000), sku: "SKU#{i}", description: "商品#{i}の説明文です。")
  image = File.open('https://s3-ap-northeast-1.amazonaws.com/nagumo-storage/cart.jpg')
  item.image.attach(io: image, filename: 'cart.jpg')
end
