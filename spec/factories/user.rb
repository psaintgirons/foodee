FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name                              }
    last_name  { Faker::Name.last_name                               }
    profile    { User::PROFILES.sample                               }
    email      { Faker::Internet.email("#{first_name}_#{last_name}") }
    password '1234567890'

    User::PROFILES.each do |pr|
      factory pr do
        profile { pr }
      end
    end
  end
end