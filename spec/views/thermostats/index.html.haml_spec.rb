require 'rails_helper'

RSpec.describe "thermostats/index", :type => :view do
  before(:each) do
    assign(:thermostats, [
      Thermostat.create!(
        :mode => 1,
        :status => 2
      ),
      Thermostat.create!(
        :mode => 1,
        :status => 2
      )
    ])
  end

  it "renders a list of thermostats" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
