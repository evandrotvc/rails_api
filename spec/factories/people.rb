# frozen_string_literal: true

FactoryBot.define do
  factory :person do
    name { Faker::Name.name }
    gender { Faker::Gender.binary_type }
    status { :survivor }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
