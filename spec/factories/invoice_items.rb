FactoryBot.define do
  factory :invoice_item do
    association :invoice
    association :item
    quantity { 1 }
    unit_price { "9999" }
  end
end
