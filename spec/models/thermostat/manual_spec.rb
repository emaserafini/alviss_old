require 'rails_helper'

RSpec.describe Thermostat::Manual, type: :model do
  subject { described_class.new current_temperature: 20.0, setpoint_temperature: 21.5 }

  describe '::initialize' do
    it 'sets #current_temperature' do
      expect(subject.current_temperature).to eq 20.0
    end

    it 'sets #setpoint_temperature' do
      expect(subject.setpoint_temperature).to eq 21.5
    end

    describe 'with options parameter' do
      let(:options) { { latest_started_at: 'something', minimum_run: 1000, deviation_temperature: 0.6 } }
      subject { described_class.new current_temperature: 20.0, setpoint_temperature: 21.5, options: options }

      it 'assigns an instance variable for all passed options' do
        options.each do |k, v|
          expect(subject.send(k)).to eq v
        end
      end
    end
  end

  describe '#status' do
    let(:options) { {
      latest_started_at: 15.minutes.ago,
      minimum_run: 5.minutes.seconds,
      deviation_temperature: 0.6
    } }
    subject { described_class.new current_temperature: 20.0, setpoint_temperature: 21.5, options: options }

    context 'when at least one of #current_temperature or setpoint temperature is not valid' do
      it 'responds :unknown when nil' do
        allow(subject).to receive(:current_temperature).and_return nil
        expect(subject.status).to eq :unknown
      end

      it 'responds :unknown when not numeric' do
        allow(subject).to receive(:current_temperature).and_return 'not_numeric'
        expect(subject.status).to eq :unknown
      end
    end

    context 'with valid temperatures' do
      context 'when cannot turn off' do
        it 'responds :on' do
          subject.latest_started_at = 2.minutes.ago
          expect(subject.status).to eq :on
        end
      end

      context 'when can turn off' do
        it 'responds :off when #current_temperature is higher than #target_temperature' do
          subject.current_temperature = subject.setpoint_temperature + 1
          expect(subject.status).to eq :off
        end

        it 'responds :on when #current_temperature is lower than #target_temperature' do
          subject.current_temperature = subject.setpoint_temperature - 1
          expect(subject.status).to eq :on
        end
      end

      context 'when can turn off' do
        it 'responds :on when #current_temperature is higher than #target_temperature' do
          subject.current_temperature = subject.setpoint_temperature + 0.2
          expect(subject.status).to eq :on
        end

        it 'responds :off when #current_temperature is lower than #target_temperature' do
          subject.current_temperature = subject.setpoint_temperature - 0.2
          expect(subject.status).to eq :off
        end
      end
    end
  end

  describe '#target_temperature' do
    let(:options) { { deviation_temperature: 0.6 } }
    subject { described_class.new current_temperature: 19.5, setpoint_temperature: 20.0, options: options }

    context 'when check_deviation is false' do
      it 'returns setpoint_temperature value' do
        subject.deviation_temperature = nil
        expect(subject.target_temperature).to eq subject.setpoint_temperature
      end
    end

    context 'when check_deviation is true' do
      it 'returns deviation high if current_temperature is higher than setpoint_temperature' do
        subject.current_temperature = 20.5
        expect(subject.target_temperature).to eq(subject.setpoint_temperature + (subject.deviation_temperature / 2))
      end

      it 'returns deviation low if current_temperature is lower than setpoint_temperature' do
        expect(subject.target_temperature).to eq(subject.setpoint_temperature - (subject.deviation_temperature / 2))
      end
    end
  end

  describe '#minimum_run_enabled?' do
    it 'returns true when latest_started_at and minimum_run are present and valid' do
      subject.minimum_run = 10000
      subject.latest_started_at = Time.now
      expect(subject.minimum_run_enabled?).to be_truthy
    end

    it 'returns false when latest_started_at or minimum_run is invalid' do
      expect(subject.minimum_run_enabled?).to be_falsy
    end
  end

  describe '#deviation_enabled?' do
    it 'returns true when deviation_temperature is a float' do
      subject.deviation_temperature = 0.6
      expect(subject.deviation_enabled?).to be_truthy
    end

    it 'returns false when deviation_temperature is not a float' do
      subject.deviation_temperature = nil
      expect(subject.deviation_enabled?).to be_falsy
    end
  end

  describe '#can_turn_off?' do
    before { subject.minimum_run = 15.minutes.seconds }

    it 'returns true when minimum_run_enabled? is false' do
      expect(subject.can_turn_off?).to be_truthy
    end

    it 'returns true when is passed enough time since latest_started_at' do
      subject.latest_started_at = 20.minutes.ago
      expect(subject.can_turn_off?).to be_truthy
    end

    it 'returns false is not passed enough time since latest_started_at' do
      subject.latest_started_at = 5.minutes.ago
      expect(subject.can_turn_off?).to be_falsy
    end
  end
end