class Spacecraft < ApplicationRecord
  belongs_to :space_agency
  has_many :travels
  has_many :document, as: :documentable
  has_many :image, as: :imageable

  validates :name, :type, presence: true
  validates :velocity, numericality: { only_integer: true, greater_than: 0 }
  validates :fuel_in_days, numericality: { only_integer: true }
end
