module Api
  class DataTemperaturesController < BaseController
    before_action :authenticate, only: :create

    def index
      if current_feed && current_feed.data.any?
        render json: current_feed.data
      else
        render json: [], status: :not_found
      end
    end

    def show
      temperature = DataTemperature.find_by_id(params[:id])
      if temperature
        render json: temperature
      else
        render json: [], status: :not_found
      end
    end

    def create
      temperature = DataTemperature.new(temperature_params.merge(feed: current_feed))
      if temperature.save
        render json: temperature, location: api_feed_data_temperature_path(temperature.feed_id, temperature.id), status: :created
      else
        render json: { errors: temperature.errors }, status: :unprocessable_entity
      end
    end


    private

    def temperature_params
      params.require(:data_temperature).permit(:value)
    end

    def current_feed
      @feed = Feed.find_by_id(params[:feed_id])
    end

  end
end
