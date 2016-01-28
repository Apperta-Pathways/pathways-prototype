require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

DatabaseCleaner.clean

# Categories,subcategories and data modules
@category = []
@subcategory= []
@datamodule = []

@category << FactoryGirl.create(:category, name:'Respiratory diseases')
@category << FactoryGirl.create(:category, name:'Eating disoders')
@category << FactoryGirl.create(:category, name:'Skin conditions')

@subcategory << FactoryGirl.create(:subcategory, name:'Inflamatory lung disease', category: @category[0])
@subcategory << FactoryGirl.create(:subcategory, name:'Restrictive lung diseases', category: @category[0])
@subcategory << FactoryGirl.create(:subcategory, name:'Respiratory tract infection', category: @category[0])

@datamodule << FactoryGirl.create(:data_module, subcategory: @subcategory[0], title: 'Description', data: "Characterized by a high neutrophil count, e.g. asthma, cystic fibrosis, emphysema, chronic obstructive pulmonary disorder or acute respiratory distress syndrome.[1] Asthma is one of the deadly lung diseases. Asthma is a disease that infects the airways leading to the loss of the control over the smooth muscles that line the bronchi and bronchioles. When exposed to an irritant such as dust or smoke, the smooth muscles that line airways of the asthmatic patient start to contract faster and stronger leading to difficulty breathing.[11]")

@datamodule << FactoryGirl.create(:data_module, subcategory: @subcategory[1], title: 'Description', data: "Restrictive lung diseases are a category of respiratory disease characterized by a loss of lung compliance,[2] causing incomplete lung expansion and increased lung stiffness, such as in infants with respiratory distress syndrome.")

@datamodule << FactoryGirl.create(:data_module, subcategory: @subcategory[2], title: 'Upper respiratory tract infection', data: "The most common upper respiratory tract infection is the common cold. However, infections of specific organs of the upper respiratory tract such as sinusitis, tonsillitis, otitis media, pharyngitis and laryngitis are also considered upper respiratory tract infections.")
@datamodule << FactoryGirl.create(:data_module, subcategory: @subcategory[2], title: 'Lower respiratory tract infection', data: "The most common lower respiratory tract infection is pneumonia, an infection of the lungs which is usually caused by bacteria, particularly Streptococcus pneumoniae in Western countries. Worldwide, tuberculosis is an important cause of pneumonia. Other pathogens such as viruses and fungi can cause pneumonia for example severe acute respiratory syndrome and pneumocystis pneumonia. A pneumonia may develop complications such as a lung abscess, a round cavity in the lung caused by the infection, or may spread to the pleural cavity.")

3.times do |i|
    @subcategory << FactoryGirl.create(:subcategory, category: @category[1])
end

2.times do |i|
    @subcategory << FactoryGirl.create(:subcategory, category: @category[2])
end


# Patients, pathways and treatment modules/states
@pathway=[]
@patients=[]
@states = []

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

# Doctors and superusers
@doctors = []
@test_doctor = FactoryGirl.create(:doctor, password: "test_pass", email: 'superuser@test.com', superuser: true)
@test_doc = FactoryGirl.create(:doctor, password: "test_pass", email: 'doctor@test.com', superuser: false)

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

