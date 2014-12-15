require 'rails_helper'

RSpec.describe Api::DataTemperaturesController, :type => :controller do
  let!(:feed) { create(:feed) }
  let(:accept_json) { { "Accept" => "application/json" } }
  let(:json_content_type) { { "Content-Type" => "application/json" } }
  let(:accept_and_return_json) { accept_json.merge(json_content_type) }

  describe 'GET feeds/1/api/data_temperatures' do
    describe 'without data' do
      it 'returns no temperatures' do
        get :index, { feed_id: feed.id }, accept_json
        expect(response.status).to eq 404
        expect(response.body).to eq('{}')
      end
    end

    describe 'with some data' do
      before { DataTemperature.create(feed: feed, value: 20) }
      it 'returns all the temperatures' do
        get :index, { feed_id: feed.id }, accept_json
        expect(response.status).to eq 200
        body              = JSON.parse(response.body)
        temperature_value = body.map { |m| m["value"].to_f }
        expect(temperature_value).to match_array([20.0])
      end
    end
  end
end
