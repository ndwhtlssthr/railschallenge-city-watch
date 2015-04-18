class RespondersController < ApplicationController
  def create
    @responder = Responder.new(responder_params)

    if @responder.save
      render json: @responder
    else
      render json: 'error'.to_json
    end
  end

  private

  def responder_params
    params.require(:responder)
      .permit(:emergency_code, :type, :name, :capacity, :on_duty)
  end
end
