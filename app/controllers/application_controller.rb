class ApplicationController < ActionController::API
  def route_not_found
    render json: {success: false, message: 'request url not found'}, status: :not_found, layout: false
  end
end
