require 'rails_helper'

RSpec.describe WeeklySchedule, type: :model do
  subject { described_class.new raw_schedule }
  let(:raw_schedule) { { 0 => [
                              { time:  '5:00', temp: 20 },
                              { time: '10:30', temp: 21 }
                            ],
                       1 => [
                              { time: '10:00', temp: 20 },
                              { time: '15:30', temp: 22 },
                              { time: '23:00', temp: 21 }
                            ],
                       2 => [],
                       3 => [
                              { time: 'error', temp: 20}
                            ]
                     }
                   }
  let(:current_day) { 0 }
  let(:monday) { 1 }
  let(:tuesday) { 2 }

  describe '::initialize' do
    context 'when raw_schedule is passed' do
      it 'call #build_schedule' do
        expect_any_instance_of(described_class).to receive(:build_schedule)
        described_class.new('raw_schedule')
      end

      it 'sets #schedule' do
        expect(subject.schedule).not_to be_nil
      end
    end
  end

  describe '#build_schedule' do
    subject { described_class.new }

    it 'sets schedule as array' do
      subject.build_schedule({})
      expect(subject.schedule).to be_kind_of Array
    end

    it 'sets schedule as array of 7 elements' do
      subject.build_schedule({})
      expect(subject.schedule.size).to eq 7
    end

    context 'when raw_schedule is empty' do
      it 'sets schedule as an array of 7 empty arrays' do
        subject.build_schedule({})
        subject.schedule.each do |a|
          expect(a).to be_empty
        end
      end
    end
  end

  describe '#daily_schedule' do
    it 'returns an Array' do
      expect(subject.daily_schedule).to be_a Array
    end

    it 'returns an empty array if there are no activities in week day' do
      allow(DateTime).to receive_message_chain(:now, :wday).and_return(tuesday)
      expect(subject.daily_schedule).to be_empty
    end

    context 'without week day param' do
      it 'returns activities for the current day' do
        allow(DateTime).to receive_message_chain(:now, :wday).and_return(current_day)
        expect(subject.daily_schedule).to eq subject.schedule[current_day]
      end
    end

    context 'with week day param' do
      it 'return programming for selected week day' do
        expect(subject.daily_schedule(monday)).to eq subject.schedule[monday]
      end
    end
  end

  describe '#activities_times' do
    it 'returns an Array of times of day for given weekday' do
      expect(subject.activities_times(monday)).to be_kind_of Array
    end

    it 'returns an empty array if there are no schedule for given weekday' do
      expect(subject.activities_times(tuesday)).to be_empty
    end
  end

  describe '#activity_for' do
    it 'returns activity for given weekday and time of day' do
      expect(subject.activity_for(monday, '11')).to eq({ time: '10:00', temp: 20 })
    end

    it 'returns activity of the previous day if there are no matches in selected' do
      expect(subject.activity_for(monday, '3')).to eq({ time: '10:30', temp: 21 })
      expect(subject.activity_for(current_day, '2')).to eq({ time: '23:00', temp: 21 })
    end
  end
end