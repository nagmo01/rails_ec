namespace :promotion_code do
  desc "プロモーションコードを発行"
  task generate: :environment do
    10.times do
      @promotion_code = PromotionCode.new
      @promotion_code.code = SecureRandom.alphanumeric(7)
      @promotion_code.discount_amount = rand(100..1000)
      @promotion_code.save!
    end
  end

end
