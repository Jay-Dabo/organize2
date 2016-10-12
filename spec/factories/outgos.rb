FactoryGirl.define do
  factory :outgo do
    association :chargeable, factory: :account, strategy: :cache

    description 'Outgo#1'
    value 100
    paid_at Date.current

    factory :outgo2 do
      description 'Outgo#2'
    end
  end
end