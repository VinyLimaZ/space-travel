class Ufo < Spacecraft
  has_one :ufo_datum, required: false
  delegate :max_crew_size, to: :ufo_datum, allow_nil: true
end
