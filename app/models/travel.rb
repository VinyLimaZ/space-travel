class Travel < ApplicationRecord
  belongs_to :planet
  belongs_to :spacecraft
  has_many :document, as: :documentable

  validates :duration, numericality: { only_integer: true }

  enum status: {
    schedule: 0,
    started: 1,
    aborted: 2,
    failed: 3,
    finished: 4
  }
end
