class EmergenciesController < ApplicationController
  def index
    render json: Emergency.all
  end

  def show
    @emergency = Emergency.find_by(code: params[:id])
    if @emergency
      render json: @emergency, status: 201
    else
      render_not_found
    end
  end

  def create
    @emergency = Emergency.new(emergency_create_params)
    if @emergency.save
      render json: @emergency, status: 201
    else
      render json: { message: @emergency.errors.messages }, status: 422
    end
  end

  private

  def emergency_create_params
    params.require(:emergency)
      .permit(:code, :fire_severity, :police_severity, :medical_severity)
  end
end
