# frozen_string_literal: true

class SpaceShuttle < Spacecraft
  belongs_to :space_agency
  has_one :space_shuttle_datum, required: false
  has_many :document, as: :documentable
  has_many :image, as: :imageable

  delegate :max_crew_size, to: :space_shuttle_datum, allow_nil: true

  accepts_nested_attributes_for :space_shuttle_datum, update_only: true
end
