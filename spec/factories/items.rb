FactoryBot.define do
  factory :item do
    name { "Banana Stand" }
    description { "There's always money in the banana stand." }
    association :merchant
  end
end
