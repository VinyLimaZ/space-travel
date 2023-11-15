class Ufo < Spacecraft
  has_one :ufo_datum, required: false
  has_many :document, as: :documentable
  has_many :image, as: :imageable

  delegate :max_crew_size, to: :ufo_datum, allow_nil: true
end
