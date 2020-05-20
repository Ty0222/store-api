FactoryBot.define do
  factory :line_item do
    sequence(:code) { |n| "PC #{n}" }
    quantity { 1 }
    price { 2.00 }
    total { 2.00 }
  end  
end
