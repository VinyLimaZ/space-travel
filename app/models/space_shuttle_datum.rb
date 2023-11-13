class SpaceShuttleDatum < ApplicationRecord
  belongs_to :space_shuttle,
    inverse_of: :space_shuttle_datum,
    dependent: :destroy

  validates :max_crew_size, numericality: { only_integer: true }
end
