class RespondersController < ApplicationController
  def create
    @responder = Responder.new(responder_params)
    if @responder.save
      render json: @responder, status: 201
    else
      render json: { message: @responder.errors.messages }, status: 422
    end
  end

  private

  def responder_params
    params.require(:responder).permit(:type, :name, :capacity)
  end

  rescue_from(ActionController::UnpermittedParameters) do |pme|
    render json: {
      message: "found unpermitted parameter: #{ pme.params.first }"
    }, status: 422
  end
end
