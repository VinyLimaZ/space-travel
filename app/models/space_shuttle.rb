class SpaceShuttle < Spacecraft
  has_one :space_shuttle_datum, required: true
  delegate :max_crew_size, to: :space_shuttle_datum
end
