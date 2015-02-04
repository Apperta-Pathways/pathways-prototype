# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    sequence(:name) { |n| "Team #{n}"}
    description { Faker::Lorem.paragraph(1) }
  end

  factory :full_team, parent: :team do

    # set default numbers of patients and doctors
    ignore do
      doctors 10
      patients 50
    end

    after(:create) do |team, ev|
      create_list(:patient, ev.patients, teams: [team])
      create_list(:doctor, ev.patients, teams: [team])
    end

  end

end
