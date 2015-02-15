FactoryGirl.define do

  factory :patient do
    name { Faker::Name.name }
    email { Faker::Internet.safe_email }
    nhs_number { Faker::Number.number(10) }
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
    data { Faker::Lorem.paragraph(5)}  
    subcategory
  end

  factory :pathway do
    disease { Faker::Lorem.word }
    patient
  end
  
  factory :treatment_state do
    timeframe 'past'
    pathway
  end

  factory :treatment_module do
    treatment_state
    data_module
  end


end
