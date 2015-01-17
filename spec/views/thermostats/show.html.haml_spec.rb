require 'rails_helper'

RSpec.describe "thermostats/show", :type => :view do
  before(:each) do
    @thermostat = assign(:thermostat, Thermostat.create!(
      :mode => 1,
      :status => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
