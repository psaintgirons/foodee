FactoryGirl.define do
  factory :reservation do
    reserved_at { Time.zone.today }
  end
end