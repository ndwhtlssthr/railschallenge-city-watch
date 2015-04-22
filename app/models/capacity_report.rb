class CapacityReport
  def self.to_json
    {
      'capacity': {
        'Fire': capacity('Fire'),
        'Police': capacity('Police'),
        'Medical': capacity('Medical')
      }
    }.to_json
  end

  def self.capacity(type)
    [
      Responder.total_capacity(type),
      Responder.not_on_response_capacity(type),
      Responder.on_duty_capacity(type),
      Responder.available_capacity(type)
    ]
  end
end
