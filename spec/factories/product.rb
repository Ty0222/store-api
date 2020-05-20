FactoryBot.define do
  factory :product do
    trait :coca_cola do
      code { "CC" }
      name { "Coca-Cola" }
      price { 1.50 }
    end

    trait :pepsi_cola do
      code { "PC" }
      name { "Pepsi-Cola" }
      price { 2.00 }
    end

    trait :water do
      code { "WA" }
      name { "Water" }
      price { 0.85 }
    end
  end  
end
