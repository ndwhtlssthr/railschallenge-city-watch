class Responder < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  validates :capacity, presence: true
  validates :capacity, inclusion: {
    in: 1..5,
    message: 'is not included in the list'
  }
end
