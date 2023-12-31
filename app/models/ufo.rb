# frozen_string_literal: true

class Ufo < Spacecraft
  belongs_to :space_agency
  has_one :ufo_datum, required: false
  has_many :document, as: :documentable
  has_many :image, as: :imageable

  delegate :max_crew_size, to: :ufo_datum, allow_nil: true

  accepts_nested_attributes_for :ufo_datum, update_only: true
end
