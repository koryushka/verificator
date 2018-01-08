class Campaign < ApplicationRecord
  validates :external_reference, uniqueness: true

  enum status: {
    active: 0,
    paused: 1,
    deleted: 2
  }
end
