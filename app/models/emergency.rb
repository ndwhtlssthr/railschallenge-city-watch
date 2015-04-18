class Emergency < ActiveRecord::Base
  validates :code, :fire_severity, :police_severity, :medical_severity,
            presence: true
  validates :fire_severity, :police_severity, :medical_severity,
            numericality: { greater_than_or_equal_to: 0 }
  validates :code, uniqueness: true

  def self.full_response_count
    1
  end
end
