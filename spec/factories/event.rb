FactoryGirl.define do
  factory :event do
    title          { Faker::Commerce.product_name }
    description    { Faker::Lorem.sentence        }
    finalized_date { Time.zone.today              }
  end
end