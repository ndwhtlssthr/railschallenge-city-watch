class ApplicationController < ActionController::Base
  rescue_from(ActionController::UnpermittedParameters) do |pme|
    render json: {
      message: "found unpermitted parameter: #{ pme.params.first }"
    }, status: 422
  end

  def render_not_found
    render json: { message: 'page not found' }, status: 404
  end
end
