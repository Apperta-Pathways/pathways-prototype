# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

DatabaseCleaner.clean

@category = []
@subcategory= []
@datamodule = []

10.times do |i|
  @category << FactoryGirl.create(:category)
end

50.times do |i|
  @subcategory << FactoryGirl.create(:subcategory, category: @category.sample)
end

1000.times do |i|
  @datamodule << FactoryGirl.create(:data_module, subcategory: @subcategory.sample)
end

@pathway=[]
@patients=[]

30.times do |i|
  @patient = FactoryGirl.create(:patient)
  @patients << @patient
  @pathway << FactoryGirl.create(:pathway, patient: @patient)
end

@states = []

@pathway.each do |i|
    2.times do |s|
        @states << FactoryGirl.create(:treatment_state, pathway: i, timeframe: 'past') 
    end

    3.times do |s|
        @states << FactoryGirl.create(:treatment_state, pathway: i, timeframe: 'present')
    end

    2.times do |s|
        @states << FactoryGirl.create(:treatment_state, pathway: i, timeframe: 'future')
    end
end

@states.each do |i|
    3.times do |s|
        FactoryGirl.create(:treatment_module, treatment_state: i, data_module: @datamodule.sample)
    end
end

@test_patient = FactoryGirl.create(:patient, password: "test_pass", email: 'test@test.com')
@test_pathway = FactoryGirl.create(:pathway, patient: @test_patient)

@test_states = []

2.times do |s|
    @test_states << FactoryGirl.create(:treatment_state, pathway: @test_pathway, timeframe: 'past') 
end

3.times do |s|
    @test_states << FactoryGirl.create(:treatment_state, pathway: @test_pathway, timeframe: 'present')
end

2.times do |s|
    @test_states << FactoryGirl.create(:treatment_state, pathway: @test_pathway, timeframe: 'future')
end

@test_states.each do |i|
  3.times do |s|
      FactoryGirl.create(:treatment_module, treatment_state: i, data_module: @datamodule.sample)
  end
end

@doctors = []

30.times do |s|
  @doctors << FactoryGirl.create(:doctor)
end

3.times do|s|
  @team =  FactoryGirl.create(:team)
  3.times do |i|
    @team.doctors << @doctors.sample
    @team.patients << @patients.sample
  end
end
