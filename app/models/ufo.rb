class Ufo < Spacecraft
  has_one :ufo_datum, required: false
  has_many :document, as: :documentable

  delegate :max_crew_size, to: :ufo_datum, allow_nil: true
end
