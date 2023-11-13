class Ufo < Spacecraft
  has_one :ufo_datum, required: true
  delegate :max_crew_size, to: :ufo_datum
end
