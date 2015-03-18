require 'rails_helper'

RSpec.describe Patient, type: :model do

  context 'associations' do

    it { should have_one(:pathway) }
    it { should have_many(:treatment_states) }
    it { should have_many(:treatment_modules) }
  end


end
