FactoryGirl.define do
  factory :product do
    name         { Faker::Commerce.product_name }
    description  { Faker::Lorem.sentence        }
    category     { Product::CATEGORIES.sample   }
    product_type { Product::TYPES.values.sample }
    price        { Faker::Commerce.price        }
  end
end