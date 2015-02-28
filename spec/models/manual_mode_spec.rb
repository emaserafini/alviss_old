require 'rails_helper'

RSpec.describe ManualMode, type: :model do
  describe '#current_temperature' do
    before { subject.feed_temperature = Feed.new(data_kind: :data_temperature) }

    it 'delegates to feed#current_data' do
      expect_any_instance_of(Feed).to receive(:current_data)
      subject.current_temperature
    end
  end

  describe '#status' do
    subject { create(:manual_mode, deviation_temperature: 0.6, minimum_run: 5.minutes.seconds) }

    before do
      allow(subject).to receive(:current_temperature).and_return 20.to_d
    end

    context 'when at least one of current temperature or setpoint temperature is not valid' do
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
          allow(subject).to receive(:latest_started_at).and_return 2.minutes.ago
          expect(subject.status).to eq :on
        end
      end

      context 'when can turn off' do
        it 'responds :off when current temperature is higher than setpoint temperature' do
          allow(subject).to receive(:current_temperature).and_return subject.setpoint_temperature + 1
          expect(subject.status).to eq :off
        end

        it 'responds :on when current temperature is lower than setpoint temperature' do
          allow(subject).to receive(:current_temperature).and_return subject.setpoint_temperature - 1
          expect(subject.status).to eq :on
        end
      end
    end
  end

  describe '#minimum_run_enabled?' do
    it 'returns true when latest_started_at and minimum_run are present and valid' do
      subject.minimum_run = 10000
      allow(subject).to receive(:latest_started_at).and_return Time.now
      expect(subject.minimum_run_enabled?).to be_truthy
    end

    it 'returns false when latest_started_at or minimum_run is invalid' do
      expect(subject.minimum_run_enabled?).to be_falsy
    end
  end

  describe '#deviation_enabled?' do
    it 'returns true when deviation_temperature is a decimal' do
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
      allow(subject).to receive(:latest_started_at).and_return 20.minutes.ago
      expect(subject.can_turn_off?).to be_truthy
    end

    it 'returns false is not passed enough time since latest_started_at' do
      allow(subject).to receive(:latest_started_at).and_return 5.minutes.ago
      expect(subject.can_turn_off?).to be_falsy
    end
  end

  describe '#target_temp' do
    subject { create(:manual_mode, deviation_temperature: 0.6) }

    context 'when check_deviation is false' do
      it 'returns setpoint_temp value' do
        subject.deviation_temperature = nil
        expect(subject.target_temperature).to eq subject.setpoint_temperature
      end
    end

    context 'when check_deviation is true' do
      it 'returns deviation high if current_temp is higher than setpoint_temperature' do
        allow(subject).to receive(:current_temperature).and_return 20.5
        expect(subject.target_temperature).to eq(subject.setpoint_temperature + (subject.deviation_temperature / 2))
      end

      it 'returns deviation low if current_temp is lower than setpoint_temperature' do
        allow(subject).to receive(:current_temperature).and_return 19.5
        expect(subject.target_temperature).to eq(subject.setpoint_temperature - (subject.deviation_temperature / 2))
      end
    end
  end
end