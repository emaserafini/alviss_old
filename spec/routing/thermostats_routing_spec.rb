require "rails_helper"

RSpec.describe ThermostatsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/thermostats").to route_to("thermostats#index")
    end

    it "routes to #new" do
      expect(:get => "/thermostats/new").to route_to("thermostats#new")
    end

    it "routes to #show" do
      expect(:get => "/thermostats/1").to route_to("thermostats#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/thermostats/1/edit").to route_to("thermostats#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/thermostats").to route_to("thermostats#create")
    end

    it "routes to #update" do
      expect(:put => "/thermostats/1").to route_to("thermostats#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/thermostats/1").to route_to("thermostats#destroy", :id => "1")
    end

  end
end
