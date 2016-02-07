require 'database_cleaner'
require 'pathname'

DatabaseCleaner.strategy = :truncation

DatabaseCleaner.clean

# Categories,subcategories and data modules
@category = [] 
@subcategory= []
@datamodule = []

        
base_path = File.join(Rails.root, 'db', 'content')

categories = Pathname.new(base_path).children.select { |c| c.directory? }.collect { |p| p.basename.to_s }

for cat in categories
    @category << FactoryGirl.create(:category, name: cat)
    puts 'Category: ' + cat

    subcategories = Pathname.new(File.join(base_path, cat)).children.select { |c| c.directory? }.collect { |p| p.basename.to_s }
    for subcat in subcategories 
        @subcategory << FactoryGirl.create(:subcategory, name: subcat, category: @category[-1]) 
        puts 'Subcategory: ' + subcat

        data_modules = Pathname.new(File.join(base_path, cat, subcat)).children.select { |c| c.file? }.collect { |p| p.basename.to_s }
        for dm in data_modules
            filename = File.join(base_path, cat, subcat, dm)
            @datamodule << FactoryGirl.create(:data_module, subcategory:@subcategory[-1], title: dm.to_s.split('.')[0], data: File.read(filename))

            puts 'Data module: ' + dm
        end
    end
end

# Test accounts
@test_patient = FactoryGirl.create(:patient, email:'patient@test.com', password: 'test_pass')
@test_superuser = FactoryGirl.create(:doctor, password: "test_pass", email: 'superuser@test.com', superuser: true)
@test_doctor = FactoryGirl.create(:doctor, password: "test_pass", email: 'doctor@test.com', superuser: false)


# Patients, pathways and treatment modules/states
@pathway=[]
@patients=[]
@states = []

@pathway << FactoryGirl.create(:pathway, patient: @test_patient)

10.times do |i|
  @patient = FactoryGirl.create(:patient, password: 'test_pass')
  @patients << @patient
  @pathway << FactoryGirl.create(:pathway, patient: @patient)
end


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


# Doctors
@doctors = []
10.times do |s|
  @doctors << FactoryGirl.create(:doctor)
end

3.times do|s|
  @team =  FactoryGirl.create(:team)
  3.times do |i|
    @team.doctors << @doctors.sample
    @team.patients << @patients.sample
  end
end




