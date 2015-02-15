require 'rails_helper'

RSpec.describe Patient, type: :model do

  context 'associations' do
    it { should have_and_belong_to_many(:teams) }
    it { should have_and_belong_to_many(:doctors) }

    it { should have_one(:pathway) }
    it { should have_many(:treatment_states) }
    it { should have_many(:treatment_modules) }
  end

  describe 'recent' do
    before(:all) do
      @patients = FactoryGirl.create_list(:patient, 10)
    end

    it 'should return the most recently updated users' do
      expect Patient.recent(10).size to eq 10
    end
  end

end
