require 'rails_helper'

RSpec.describe Thermostat, type: :model do
  let(:thermostat) { Thermostat.new }

  describe 'class' do
    it 'respond to' do
      expect(thermostat).to respond_to(:mode)
    end
  end

  # describe 'class' do
  # +    it 'respond_to' do
  # +      expect(thermostat).to respond_to(:id)
  # +      expect(thermostat).to respond_to(:mode)
  # +      expect(thermostat).to respond_to(:mode)
  # +      expect(thermostat).to respond_to(:target_temperature)
  # +      expect(thermostat).to respond_to(:latest_started_at)
  # +      expect(thermostat).to respond_to(:latest_stopped_at)
  # +      expect(thermostat).to respond_to(:check_mode)
  # +    end
  # +  end


  describe 'initialization' do
    it 'is inactive' do
      expect(thermostat).to be_inactive
      expect(thermostat.mode).to eq :inactive
    end

    it 'current_status is unknown' do
      expect(thermostat.current_status).to eq :unknown
    end
  end

  describe 'operation mode >> manual' do
    before { thermostat.mode = :manual }
    context 'when current temperature is below target temperature' do
      fit 'status should be :on' do
        expect(thermostat.current_status).to eq :on
      end
    end
    context 'when current temperature is over target temperature status should be :off' do
      it { expect(thermostat.current_status).to eq :off }
    end
  end
end
