class Planet < ApplicationRecord
  has_many :travels
  has_many :document, as: :documentable

  validates :name, presence: true
  validates :earth_distance, numericality: { only_integer: true, greater_than: 0 }
end
