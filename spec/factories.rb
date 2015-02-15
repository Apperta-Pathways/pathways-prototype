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
    title { Faker::Lorem.word }
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

  factory :full_pathway, parent: :pathway do

    after(:create) do |pathway, e|
      @categories = create_list(:category, 5)
      @categories.each do |c|
        s = create_list(:subcategory, 5, category: c)
        s.each { |s| create_list(:data_module, 5, subcategory: s) }
      end

      @treatment_states = create_list(:treatment_state, 5, pathway: pathway)

      @treatment_states.each do |t|
        create_list(:treatment_module, 5,
                    treatment_state: t,
                    data_module: @categories.sample.data_modules.sample)
      end
    end
  end

end
