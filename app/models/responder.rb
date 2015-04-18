class Responder < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  validates :name, uniqueness: true
  validates :capacity, :name, :type, presence: true
  validates :capacity, inclusion: { in: 1..5 }

  def self.total_capacity(type)
    where(type: type).sum(:capacity)
  end

  def self.not_on_response_capacity(type)
    where(type: type).where(on_response: false).sum(:capacity)
  end

  def self.on_duty_capacity(type)
    where(type: type).where(on_duty: true).sum(:capacity)
  end

  def self.available_capacity(type)
    where(type: type).where(on_response: false).where(on_duty: true)
      .sum(:capacity)
  end
end
