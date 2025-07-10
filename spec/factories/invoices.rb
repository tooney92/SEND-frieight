FactoryBot.define do
  factory :invoice do
    reference { Faker::Alphanumeric.alphanumeric(number: 10).upcase }
    bill_of_lading_number { build(:bill_of_lading).number }
    client_code { Faker::Alphanumeric.alphanumeric(number: 5).upcase }
    client_name { Faker::Company.name }
    amount { rand(100_000..1_000_000) }
    original_amount { amount }
    devise { "XOF" }
    status { "init" }
    invoice_date { Date.today }
    id_utilisateur { 1 }
  end
end
