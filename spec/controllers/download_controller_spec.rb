require 'rails_helper'

RSpec.describe DownloadController, :type => :controller do

  describe "GET log" do
    it "returns http success" do
      get :log
      expect(response).to be_success
    end
  end

end
