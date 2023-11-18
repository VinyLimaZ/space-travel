# frozen_string_literal: true

class Spacecraft < ApplicationRecord
  belongs_to :space_agency, foreign_key: :space_agency_id

  has_many :travels
  has_many :document, as: :documentable
  has_many :image, as: :imageable

  validates :name, :type, presence: true
  validates :velocity, numericality: { only_integer: true, greater_than: 0 }
  validates :fuel_in_days, numericality: { only_integer: true }

  def crew?
    try(:max_crew_size)
  end

  def payload?
    try(:payload)
  end
end
