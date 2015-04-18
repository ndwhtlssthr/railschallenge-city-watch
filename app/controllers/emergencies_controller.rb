class EmergenciesController < ApplicationController
  def index
    render json: Emergency.all,
           meta: [Emergency.full_response_count, Emergency.count],
           meta_key: 'full_responses'
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
      Dispatcher.new(@emergency).dispatch_units
      render json: @emergency, status: 201
    else
      render json: { message: @emergency.errors.messages }, status: 422
    end
  end

  def update
    @emergency = Emergency.find_by(code: params[:id])
    @emergency.update_attributes(emergency_update_params)
    Dispatcher.new(@emergency).resolve_emergency if @emergency.resolved_at
    render json: @emergency, status: 201
  end

  private

  def emergency_create_params
    params.require(:emergency)
      .permit(:code, :fire_severity, :police_severity, :medical_severity)
  end

  def emergency_update_params
    params.require(:emergency)
      .permit(:fire_severity, :police_severity, :medical_severity, :resolved_at)
  end
end
