class EmergenciesController < ApplicationController
  def index
    render json: Emergency.all,
           meta: [Emergency.full_response_count, Emergency.count],
           meta_key: 'full_responses'
  end

  def show
    @emergency = Emergency.find_by(code: params[:id])
    if @emergency
      render json: @emergency
    else
      render_not_found
    end
  end

  def create
    @emergency = Emergency.new(emergency_create_params)
    if @emergency.save
      dispatch_to(@emergency)
      render json: @emergency, status: :created
    else
      render json: { message: @emergency.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    @emergency = Emergency.find_by(code: params[:id])
    @emergency.update_attributes(emergency_update_params)
    @emergency.responders = [] if @emergency.resolved?
    render json: @emergency, status: :created
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

  def dispatch_to(emergency)
    responders = Responder.available_units.to_a
    dispatcher = Dispatcher.new emergency, responders
    emergency.update_attributes! responders:    dispatcher.to_dispatch,
                                 full_response: dispatcher.full_response?
  end
end
