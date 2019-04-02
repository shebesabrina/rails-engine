FactoryBot.define do
  factory :transaction do
    credit_card_number { 8675309 }
    credit_card_expiration_date { "8675309" }
    result { "success" }
    association :invoice
  end
end
