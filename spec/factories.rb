FactoryGirl.define do

  factory :patient do
    name { Faker::Name.name }
    email { Faker::Internet.safe_email }
    nhs_number { Faker::Number.number(10) }
    password { Faker::Internet.password(10) }
  end

  factory :treatment_module do
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    treatment_state
  end

  factory :pathway do
    disease { Faker::Lorem.word }
    patient
  end

  factory :treatment_state do
    timeframe 'present'
    pathway
  end


end
