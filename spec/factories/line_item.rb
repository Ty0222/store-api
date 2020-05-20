FactoryBot.define do
  factory :line_item do
    code { "PC" }
    quantity { 1 }
    price { 2.00 }
    total { 2.00 }
  end  
end
