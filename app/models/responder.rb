class Responder < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  validates :name, uniqueness: true
  validates :capacity, :name, :type, presence: true
  validates :capacity, inclusion: { in: 1..5 }

  belongs_to :emergency, foreign_key: :code, primary_key: :emergency_code

  scope :total_capacity, ->(type) { where(type: type).sum(:capacity) }
  scope :not_on_response_capacity, ->(type) { where(type: type, emergency_code: nil).sum(:capacity) }
  scope :on_duty_capacity, ->(type) { where(type: type, on_duty: true).sum(:capacity) }
  scope :available_capacity, ->(type) { where(type: type, emergency_code: nil, on_duty: true).sum(:capacity) }
  scope :available_units, -> { where(on_duty: true, emergency_code: nil) }
end
