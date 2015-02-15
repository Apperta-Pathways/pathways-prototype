require 'rails_helper'

RSpec.describe Doctor, type: :model do

  context 'associations' do
    it { should have_and_belong_to_many(:teams) }
    it { should have_and_belong_to_many(:patients) }
  end

end
