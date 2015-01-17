require 'rails_helper'

RSpec.describe "thermostats/new", :type => :view do
  before(:each) do
    assign(:thermostat, Thermostat.new(
      :mode => 1,
      :status => 1
    ))
  end

  it "renders new thermostat form" do
    render

    assert_select "form[action=?][method=?]", thermostats_path, "post" do

      assert_select "input#thermostat_mode[name=?]", "thermostat[mode]"

      assert_select "input#thermostat_status[name=?]", "thermostat[status]"
    end
  end
end
