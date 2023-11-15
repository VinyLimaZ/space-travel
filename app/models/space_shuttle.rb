class SpaceShuttle < Spacecraft
  has_one :space_shuttle_datum, required: false
  has_many :document, as: :documentable
  has_many :image, as: :imageable

  delegate :max_crew_size, to: :space_shuttle_datum, allow_nil: true
end
