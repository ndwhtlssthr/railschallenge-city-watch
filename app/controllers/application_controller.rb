class ApplicationController < ActionController::Base
  def render_not_found
    render json: { message: 'page not found' }, status: 404
  end
end
