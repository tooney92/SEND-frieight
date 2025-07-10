FactoryBot.define do
  factory :customer do
    name { "MyString" }
    status { "MyString" }
    code { "MyString" }
    group_name { "MyString" }
    pays_deposit { false }
    freetime_frigo { 1 }
    freetime_sec { 1 }
    priority { false }
    sales_rep_id { 1 }
    finance_rep_id { 1 }
    cs_rep_id { 1 }
    valid_until { "2025-07-10 01:14:24" }
    operator { "MyString" }
  end
end
