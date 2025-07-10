FactoryBot.define do
  factory :customer do
    name { Faker::Company.name }
    code { Faker::Alphanumeric.alphanumeric(number: 6).upcase }
    group_name { ["Group A", "Group B", "Group C"].sample }
    status { %w[active inactive].sample }
    pays_deposit { [true, false].sample }
    freetime_frigo { rand(3..10) }
    freetime_sec { rand(7..15) }
    priority { [true, false].sample }
    valid_until { Faker::Date.forward(days: 365 * rand(1..3)) }
    operator { "seedbot" }

    # 👇 Correct placement of `transient` inside the factory block
    transient do
      bill_count { 2 }
    end

    trait :with_billings do
      after(:create) do |customer, evaluator|
        create_list(:bill_of_lading, evaluator.bill_count, customer: customer)
      end
    end
  end
end
