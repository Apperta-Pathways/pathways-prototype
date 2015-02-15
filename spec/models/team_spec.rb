require 'rails_helper'

RSpec.describe Team, :type => :model do

  context 'associations' do
    it { should have_and_belong_to_many(:doctors) }
    it { should have_and_belong_to_many(:patients) }
  end

end
