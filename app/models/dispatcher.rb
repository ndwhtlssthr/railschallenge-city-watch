class Dispatcher
  def self.force_responsibilities
    {
      'Fire'    => :fire_severity,
      'Police'  => :police_severity,
      'Medical' => :medical_severity
    }
  end

  def self.dispatch_units(emergency)
    force_responsibilities.each do |k, v|
      severity = emergency.send(v)
      force = Responder.available_units(k)
      force.each do |unit|
        if unit.capacity <= severity
          severity -= unit.capacity
          unit.update_attribute(:emergency_id, emergency.id)
        end
        break if severity == 0
      end
      if severity > 0 && force.length > 0
        force.last.update_attribute(:emergency_id, emergency.id)
      end
    end
    if full_response?(emergency)
      emergency.update_attribute(:full_response, true)
    end
  end

  def self.resolve_emergency(emergency)
    emergency.responders.each do |responder|
      responder.update_attribute(:emergency_id, nil)
    end
  end

  def self.full_response?(emergency)
    emergency.total_response_need - emergency.total_response == 0
  end
  private_class_method :full_response?
end
