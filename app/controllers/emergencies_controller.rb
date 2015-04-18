class EmergenciesController < ApplicationController
  def create
    @emergency = Emergency.new(emergency_create_params)
    if @emergency.save
      render json: @emergency, status: 201
    else
      render "error"
    end
  end

  private

  def emergency_create_params
    params.require(:emergency)
      .permit(:code, :fire_severity, :police_severity, :medical_severity)
  end
end
