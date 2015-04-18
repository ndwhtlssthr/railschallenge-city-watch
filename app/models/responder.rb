class Responder < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  validates :name, uniqueness: true
  validates :capacity, :name, presence: true
  validates :capacity, inclusion: {
    in: 1..5,
    message: 'is not included in the list'
  }
end
