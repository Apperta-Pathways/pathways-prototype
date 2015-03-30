require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do
  it 'should force you to login' do
    visit '/admin'

    status_code.should.eq(400)


  end

end
