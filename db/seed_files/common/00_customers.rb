# frozen_string_literal: true

puts "🌱 Seeding Customers..."

5.times do
  # Create customers with associated billings using trait
  FactoryBot.create(:customer, :with_billings, bill_count: rand(2..5))
end
