class Emergency < ActiveRecord::Base
  validates :fire_severity, :police_severity, :medical_severity,
    numericality: { greater_than_or_equal_to: 0 }
end
