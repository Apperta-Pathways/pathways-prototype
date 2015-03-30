require 'rails_helper'

describe "the categories view", :type => :feature do
  before :each do
    @patient = FactoryGirl.create(:patient, password: "test_pass", email: "test@test.com")
  end

  it 'asserts the number of categories is correct' do
    visit '/categories'

    all('.category').size.should eq(@patient.categories.size)
  end




end
