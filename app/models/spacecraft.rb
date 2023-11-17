class Spacecraft < ApplicationRecord
  Rails.application.eager_load! if Rails.env.development?
  TYPES = subclasses.map(&:to_s).freeze

  belongs_to :space_agency, foreign_key: :space_agency_id

  has_many :travels
  has_many :document, as: :documentable
  has_many :image, as: :imageable

  validates :name, :type, presence: true
  validates :velocity, numericality: { only_integer: true, greater_than: 0 }
  validates :fuel_in_days, numericality: { only_integer: true }

  def has_crew?
    type.in?(%w[Ufo SpaceShuttle])
  end

  def has_payload?
    type.in?(%w[Rocket])
  end
end
