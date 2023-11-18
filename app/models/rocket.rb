# frozen_string_literal: true

class Rocket < Spacecraft
  belongs_to :space_agency
  has_one :rocket_datum, required: false
  has_one :payload, through: :rocket_datum, required: false
  has_many :document, as: :documentable
  has_many :image, as: :imageable

  accepts_nested_attributes_for :rocket_datum, update_only: true
end
