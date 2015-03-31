require 'rails_helper'

RSpec.describe Stream, type: :model do
  describe 'validations' do
    it 'require name to be present' do
      subject.valid?
      expect(subject.errors[:name].size).to eq 1
    end

    it 'require a kind to be present' do
      subject.valid?
      expect(subject.errors[:kind].size).to eq 1
    end

    it 'pass when constraints are met' do
      subject.name = 'Home temperature stream'
      subject.kind = 'temperature'
      expect(subject).to be_valid
    end
  end

  describe '#datapoints' do
    subject { create :stream }

    it 'calls #from_stream on datapoint_class' do
      expect(subject.datapoint_class).to receive(:of_stream).with(subject.id)
      subject.datapoints
    end
  end

  context 'upon destroy' do
    subject { create :stream }

    it 'calls delete_datapoints!' do
      expect(subject).to receive(:delete_datapoints!)
      subject.destroy
    end

    pending 'delete only associated datapoints' do
      create_list :temperature, 2, stream: subject
      create :temperature
      expect{ subject.destroy }.to change{ subject.datapoint_class.count }.from(3).to(1)
    end
  end

  describe '#datapoint_class' do
    it 'retrurns datapoint class from kind' do
      subject.kind = :temperature
      expect(subject.datapoint_class).to eq Datapoint::Temperature
    end
  end
end
