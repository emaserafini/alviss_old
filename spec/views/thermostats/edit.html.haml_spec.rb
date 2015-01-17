require 'rails_helper'

RSpec.describe "thermostats/edit", :type => :view do
  before(:each) do
    @thermostat = assign(:thermostat, Thermostat.create!(
      :mode => 1,
      :status => 1
    ))
  end

  it "renders the edit thermostat form" do
    render

    assert_select "form[action=?][method=?]", thermostat_path(@thermostat), "post" do

      assert_select "input#thermostat_mode[name=?]", "thermostat[mode]"

      assert_select "input#thermostat_status[name=?]", "thermostat[status]"
    end
  end
end
