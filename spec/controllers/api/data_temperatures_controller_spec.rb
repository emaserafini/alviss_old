require 'rails_helper'

RSpec.describe Api::DataTemperaturesController, :type => :controller do
  let!(:feed) { create(:feed) }

  describe 'GET #index' do
    context 'without data' do
      it 'returns no temperatures' do
        get :index, { feed_id: feed.id }
        expect(response.status).to eq 404
        expect(response.body).to eq('[]')
      end
    end

    context 'with some data' do
      before { create(:data_temperature, feed: feed) }
      it 'returns all the temperatures' do
        get :index, { feed_id: feed.id }
        expect(response.status).to eq 200
        body = JSON.parse(response.body)
        expect(body).to be_kind_of(Array)

        temperature_value = body.first['value'].to_f
        expect(temperature_value).to eq 20.0
      end
    end
  end

  describe 'POST #create' do
    let(:valid_token) { ActionController::HttpAuthentication::Token.encode_credentials('valid_token') }
    let(:invalid_token) { ActionController::HttpAuthentication::Token.encode_credentials('invalid_token') }

    context 'without token' do
      it 'respond 401 unauthorized message' do
        post :create, { feed_id: feed.id, 'data_temperature': { 'value': 20 } }
        expect(response.status).to eq 401
      end
    end

    context 'with invalid token' do
      it 'respond 401 unauthorized message' do
        request.env['HTTP_AUTHORIZATION'] = invalid_token
        post :create, { feed_id: feed.id, 'data_temperature': { 'value': 20 } }
        expect(response.status).to eq 401
      end
    end

    context 'with valid token' do
      it 'respond 201 message' do
        temperature_value = '20.32'
        request.env['HTTP_AUTHORIZATION'] = valid_token
        post :create, { feed_id: feed.id, 'data_temperature': { 'value': temperature_value } }
        expect(response.status).to eq 201

        body = JSON.parse(response.body)
        expect(temperature_value).to eq temperature_value
      end
    end
  end
end
