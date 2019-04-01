FactoryBot.define do
  factory :invoice do
    status { "MyString" }
    association :customer
    association :merchant
  end
end
