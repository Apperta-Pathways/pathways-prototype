FactoryGirl.define do

  factory :patient do
    name { Faker::Name.name }
    email { Faker::Internet.safe_email }
    nhs_number { Faker::Number.number(10) }
    password { Faker::Internet.password(10) }
  end

  factory :doctor do
    email{ Faker::Internet.safe_email }
    password { Faker::Internet.password(10) }
  end

  factory :category do
    name { Faker::Lorem.word }
  end

  factory :subcategory do
    name { Faker::Lorem.word }
    category
  end

  factory :data_module do
    title { Faker::Lorem.word }
    data { Faker::Lorem.paragraph(5)}
    subcategory
  end

  factory :pathway do
    disease { Faker::Lorem.word }
    patient
  end

  factory :treatment_state do
    assigned_date { rand(-200..200).days.ago }
    pathway
  end

  factory :treatment_module do
    treatment_state
    data_module
  end

end
