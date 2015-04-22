class Dispatcher
  attr_reader :emergency

  def initialize(emergency)
    @emergency = emergency
  end

  def dispatch_units
    force_branches.each do |type, type_severity|
      select_units(type, type_severity)
    end
    mark_full_response if full_response?
  end

  def resolve_emergency
    emergency.responders = []
  end

  private

  def select_units(type, type_severity)
    severity = emergency.send(type_severity)
    force = Responder.available_units(type)
    return if no_force_or_severity(severity, force)
    force.each do |unit|
      if severity == 0
        break
      elsif unit.capacity <= severity
        severity -= unit.capacity
        assign_unit(unit)
      end
    end
    assign_smallest_unit(force) if remaining_need?(severity)
  end

  def mark_full_response
    emergency.update_attribute(:full_response, true)
  end

  def no_force_or_severity(severity, force)
    severity == 0 || force.length == 0
  end

  def full_response?
    emergency.total_response >= emergency.total_response_need
  end

  def remaining_need?(severity)
    severity > 0
  end

  def assign_unit(unit)
    emergency.responders << unit
  end

  def assign_smallest_unit(force)
    emergency.responders << force.last
  end

  def force_branches
    {
      'Fire'    => :fire_severity,
      'Police'  => :police_severity,
      'Medical' => :medical_severity
    }
  end
end
