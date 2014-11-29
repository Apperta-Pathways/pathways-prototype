require 'rails_helper'

RSpec.describe "doctors/index", type: :view do
  before(:each) do
    assign(:doctors, [
      Doctor.create!,
      Doctor.create!
    ])
  end

  it "renders a list of doctors" do
    render
  end
end
