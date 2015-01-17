require 'rails_helper'

RSpec.describe "Thermostats", :type => :request do
  describe "GET /thermostats" do
    it "works! (now write some real specs)" do
      get thermostats_path
      expect(response).to have_http_status(200)
    end
  end
end
