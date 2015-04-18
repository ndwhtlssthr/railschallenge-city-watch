class EmergencySerializer < ActiveModel::Serializer
  attributes :code, :fire_severity, :police_severity, :medical_severity,
             :resolved_at, :full_response, :responders

  def responders
    object.responders.map(&:name)
  end

  def include_full_response?
    object.full_response == true
  end
end
