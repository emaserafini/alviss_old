require 'rails_helper'

RSpec.describe ManualMode, type: :model do
  describe '#current_temperature' do
    before { subject.feed_temperature = Feed.new(data_kind: :data_temperature) }

    it 'delegates to feed#current_data' do
      expect_any_instance_of(Feed).to receive(:current_data)
      subject.current_temperature
    end
  end
end