FactoryBot.define do
  factory :bill_of_lading do
    number { Faker::Alphanumeric.alphanumeric(number: 9).upcase }
    customer
    arrival_date { Faker::Date.backward(days: 30) }
    freetime { rand(5..10) }
    n20_sec     { rand(0..2) }
    n40_sec     { rand(0..2) }
    n20_frigo   { rand(0..2) }
    n40_frigo   { rand(0..2) }
    n20_special { rand(0..1) }
    n40_special { rand(0..1) }
    status { "arrived" }
    exempt { false }
    valid_until { Faker::Date.forward(days: 30) }
    operator { "seedbot" }
  end
end
