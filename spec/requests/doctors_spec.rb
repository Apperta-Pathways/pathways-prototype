require 'rails_helper'

RSpec.describe "Doctors", type: :request do
  describe "GET /doctors" do
    it "works! (now write some real specs)" do
      get doctors_path
      expect(response.status).to be(200)
    end
  end
end
