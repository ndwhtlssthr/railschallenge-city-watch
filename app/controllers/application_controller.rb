class ApplicationController < ActionController::Base
  rescue_from(ActionController::UnpermittedParameters) do |pme|
    render json: {
      message: "found unpermitted parameter: #{ pme.params.first }"
    }, status: :unprocessable_entity
  end

  def render_not_found
    render json: { message: 'page not found' }, status: :not_found
  end
end
