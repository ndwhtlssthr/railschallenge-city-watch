class RespondersController < ApplicationController
  def index
    if params[:show] == 'capacity'
      render json: CapacityReport.output
    else
      render json: Responder.all
    end
  end

  def show
    @responder = Responder.find_by(name: params[:id])
    if @responder
      render json: @responder
    else
      render_not_found
    end
  end

  def create
    @responder = Responder.new(responder_create_params)
    if @responder.save
      render json: @responder, status: :created
    else
      render json: { message: @responder.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    @responder = Responder.find_by(name: params[:id])
    @responder.update_attributes(responder_update_params)
    render json: @responder, status: :created
  end

  private

  def responder_create_params
    params.require(:responder).permit(:type, :name, :capacity)
  end

  def responder_update_params
    params.require(:responder).permit(:on_duty)
  end
end
