class SpaceShuttle < Spacecraft
  has_one :space_shuttle_datum, required: false
  has_many :document, as: :documentable

  delegate :max_crew_size, to: :space_shuttle_datum, allow_nil: true
end
