FactoryBot.define do
  factory :refund_request do
    bill_of_lading_number { create(:bill_of_lading).number }
    amount_requested { Faker::Commerce.price(range: 500..3000).to_d }
    status { %w[pending approved rejected].sample }
  end
end
