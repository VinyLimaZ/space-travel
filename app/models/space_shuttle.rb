class SpaceShuttle < Spacecraft
  has_one :space_shuttle_datum, required: false
  delegate :max_crew_size, to: :space_shuttle_datum, allow_nil: true
end
