require 'rails_helper'

RSpec.describe Thermostat, type: :model do

  describe '#operating_mode' do
    context 'when active_mode is nil' do
      it 'raises an error ' do
        expect{ subject.operating_mode }.to raise_error(/Not implemended mode for/)
      end
    end

    it 'builds a class name from active_mode' do
      expect(subject).to receive(:active_mode).and_return(:manual).at_least(:once)
      subject.operating_mode
    end
  end

  describe '#get_status' do
    it 'delegate to oprating mode class to #get_status' do

    end
  end
end
