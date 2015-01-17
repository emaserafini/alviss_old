require 'rails_helper'

RSpec.describe Thermostat, type: :model do
  subject(:thermostat) { described_class.new }

  describe 'class' do
    it 'respond_to' do
      expect(thermostat).to respond_to(:id)
      expect(thermostat).to respond_to(:mode)
      expect(thermostat).to respond_to(:status)
      expect(thermostat).to respond_to(:target_temperature)
      expect(thermostat).to respond_to(:latest_started_at)
      expect(thermostat).to respond_to(:latest_stopped_at)
      expect(thermostat).to respond_to(:manager)
      expect(thermostat).to respond_to(:current_status)
    end
  end

  describe '#new' do
    it ':manager' do
      expect(thermostat.manager).to be_instance_of(ThermostatManager)
    end
  end

  describe '#current_status on manual mode' do
    before do
      thermostat.mode = :manual
    end

    it 'should be :off' do
      thermostat.status = :off
      expect(thermostat.current_status).to eq(:off)
    end

    it 'should be :on' do
      thermostat.status = :on
      expect(thermostat.current_status).to eq(:on)
    end

  end
end
