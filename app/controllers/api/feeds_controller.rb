module Api
  class FeedsController < BaseController

    def show
      if feed
        render json: feed
      else
        render json: {}, status: :not_found
      end
    end

    def latest
      if feed && latest_data.present?
        render json: latest_data
      else
        render json: {}, status: :not_found
      end
    end


    private

    def latest_data
      @latest_data ||= feed.latest_data
    end

    def feed
      @feed = Feed.find_by_id(params[:id])
    end

  end
end
