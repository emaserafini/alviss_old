require 'rails_helper'

RSpec.describe Datapoint::Temperature, type: :model do
  describe 'validations' do
    it 'require stream to be present' do
      subject.valid?
      expect(subject.errors[:stream].size).to eq 1
    end

    it 'require value to be present' do
      subject.valid?
      expect(subject.errors[:value].size).to eq 1
    end

    it 'require value to be a number' do
      subject.value = 'asd'
      subject.valid?
      expect(subject.errors[:value].size).to eq 1
    end

    it 'require a scale included in' do
      subject.valid?
      expect(subject.errors[:scale].size).to eq 1
    end

    it 'pass when constraints are met' do
      subject.stream = create :stream
      subject.value = 23.5
      subject.scale = 'celsius'
      expect(subject).to be_valid
    end
  end
end
