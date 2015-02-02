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

@patient = FactoryGirl.create(:patient)
@pathway = FactoryGirl.create(:pathway, patient: @patient)

@states = []

2.times do |i|
  @states << FactoryGirl.create(:treatment_state, pathway: @pathway, timeframe: 'past')
end

3.times do |i|
  @states << FactoryGirl.create(:treatment_state, pathway: @pathway, timeframe: 'present')
end

2.times do |i|
  @states << FactoryGirl.create(:treatment_state, pathway: @pathway, timeframe: 'future')
end

@states.each do |s|
  # create two treatment modules for each stata
  2.times do |i|
    FactoryGirl.create(:treatment_module, treatment_state: s)
  end
end

@patient_new = FactoryGirl.create(:patient, password: "test_pass", email: 'test@test.com')
@pathway = FactoryGirl.create(:pathway, patient: @patient_new)
@state = FactoryGirl.create(:treatment_state, timeframe: 'present', pathway: @pathway)

10.times do |i|
  FactoryGirl.create(:treatment_module, treatment_state: @state)
end

30.times do |i|
  FactoryGirl.create(:patient)
end
