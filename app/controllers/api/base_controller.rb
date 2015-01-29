module API
  class BaseController < ActionController::Base
    protected


    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        token == 'valid_token'
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: 'invalid token', status: 401
    end
  end
end
