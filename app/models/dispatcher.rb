class Dispatcher
  attr_reader :emergency

  def initialize(emergency, responders)
    @emergency  = emergency
    @responders = responders
  end

  def to_dispatch
    run_algorithm
    @to_dispatch
  end

  def full_response?
    run_algorithm
    @full_response
  end

  private

  def run_algorithm
    return if @algorithm_has_been_ran
    @algorithm_has_been_ran = true

    @to_dispatch = force_branches.inject [] do |to_dispatch, (type, type_severity)|
      severity   = emergency.send(type_severity)
      responders = responders_for(type)
      to_dispatch + select_responders(severity, responders)
    end

    @full_response = emergency.total_response_need <= total_capacity(@to_dispatch)
  end

  def total_capacity(responders)
    responders.inject(0) { |a, e| a + e.capacity  }
  end

  def responders_for(type)
    @responders.select { |r| r.type == type  }.sort_by { |r| -r.capacity  }
  end

  def force_branches
    { 'Fire'    => :fire_severity,
      'Police'  => :police_severity,
      'Medical' => :medical_severity
    }
  end

  def select_responders(severity, responders)
    assigned = []

    responders.each do |responder|
      if responder.capacity <= severity
        severity -= responder.capacity
        assigned << responder
      end
    end

    responders -= assigned
    assigned << responders.last if responders.last && severity > 0
    assigned
  end
end
