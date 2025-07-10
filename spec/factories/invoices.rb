FactoryBot.define do
  factory :invoice do
    association :bill_of_lading

    reference { Faker::Alphanumeric.alphanumeric(number: 10).upcase }
    bill_of_lading_number { bill_of_lading.number }
    client_code { bill_of_lading.customer.code }
    client_name { bill_of_lading.customer.name }
    amount { rand(100_000..1_000_000) }
    original_amount { amount }
    devise { "USD" }
    status { "open" }
    invoice_date { Date.today }
    id_utilisateur { 1 }
  end
end
