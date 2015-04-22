class Emergency < ActiveRecord::Base
  validates :code, :fire_severity, :police_severity, :medical_severity,
            presence: true
  validates :fire_severity, :police_severity, :medical_severity,
            numericality: { greater_than_or_equal_to: 0 }
  validates :code, uniqueness: true

  has_many :responders, foreign_key: :emergency_code, primary_key: :code

  scope :full_response_count, -> { where(full_response: true).count }

  def resolved?
    resolved_at ? true : false
  end

  def total_response_need
    fire_severity + police_severity + medical_severity
  end

  def total_response
    responders.sum(:capacity)
  end
end
