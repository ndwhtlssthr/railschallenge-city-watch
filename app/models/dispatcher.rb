class Dispatcher
  def self.dispatch_units(emergency)
    emergency.update_attribute(:full_response, true)
  end
end
