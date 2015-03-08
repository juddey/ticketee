module API
  class BaseController < ApplicationController

    def current_user
      @current_user
    end

    def authenticate_user
      authenticate_with_http_token do |token|
        @current_user = User.find_by(api_key: token)
      end

      if !@current_user
        render json: { error: "Unauthorized" }, status: 401
        return
      end
    end

    def not_authorized
      render json: { error: "Unauthorized" }, status: 403
    end
  end
end